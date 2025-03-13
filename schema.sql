--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    passenger_id integer,
    flight_id integer,
    trip_id integer,
    booking_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20),
    CONSTRAINT booking_status_check CHECK (((status)::text = ANY ((ARRAY['confirmed'::character varying, 'cancelled'::character varying, 'pending'::character varying])::text[])))
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- Name: booking_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_booking_id_seq OWNER TO postgres;

--
-- Name: booking_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_booking_id_seq OWNED BY public.booking.booking_id;


--
-- Name: bustrip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bustrip (
    trip_id integer NOT NULL,
    bus_no character varying(10) NOT NULL,
    departure character varying(50) NOT NULL,
    arrival character varying(50) NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT bustrip_price_check CHECK ((price > (0)::numeric))
);


ALTER TABLE public.bustrip OWNER TO postgres;

--
-- Name: bustrip_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bustrip_trip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bustrip_trip_id_seq OWNER TO postgres;

--
-- Name: bustrip_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bustrip_trip_id_seq OWNED BY public.bustrip.trip_id;


--
-- Name: flight; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flight (
    flight_id integer NOT NULL,
    flight_no character varying(10) NOT NULL,
    departure character varying(50) NOT NULL,
    arrival character varying(50) NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT flight_price_check CHECK ((price > (0)::numeric))
);


ALTER TABLE public.flight OWNER TO postgres;

--
-- Name: flight_flight_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flight_flight_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flight_flight_id_seq OWNER TO postgres;

--
-- Name: flight_flight_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flight_flight_id_seq OWNED BY public.flight.flight_id;


--
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passenger (
    passenger_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100),
    phone character varying(15) NOT NULL
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- Name: passenger_passenger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passenger_passenger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.passenger_passenger_id_seq OWNER TO postgres;

--
-- Name: passenger_passenger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passenger_passenger_id_seq OWNED BY public.passenger.passenger_id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    booking_id integer,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    method character varying(20),
    CONSTRAINT payment_amount_check CHECK ((amount > (0)::numeric)),
    CONSTRAINT payment_method_check CHECK (((method)::text = ANY ((ARRAY['card'::character varying, 'cash'::character varying, 'online'::character varying])::text[])))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_payment_id_seq OWNER TO postgres;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- Name: booking booking_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_booking_id_seq'::regclass);


--
-- Name: bustrip trip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bustrip ALTER COLUMN trip_id SET DEFAULT nextval('public.bustrip_trip_id_seq'::regclass);


--
-- Name: flight flight_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight ALTER COLUMN flight_id SET DEFAULT nextval('public.flight_flight_id_seq'::regclass);


--
-- Name: passenger passenger_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger ALTER COLUMN passenger_id SET DEFAULT nextval('public.passenger_passenger_id_seq'::regclass);


--
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- Name: bustrip bustrip_bus_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bustrip
    ADD CONSTRAINT bustrip_bus_no_key UNIQUE (bus_no);


--
-- Name: bustrip bustrip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bustrip
    ADD CONSTRAINT bustrip_pkey PRIMARY KEY (trip_id);


--
-- Name: flight flight_flight_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_flight_no_key UNIQUE (flight_no);


--
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (flight_id);


--
-- Name: passenger passenger_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_email_key UNIQUE (email);


--
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- Name: idx_booking_passenger; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_passenger ON public.booking USING btree (passenger_id);


--
-- Name: idx_bus_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bus_no ON public.bustrip USING btree (bus_no);


--
-- Name: idx_flight_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_flight_no ON public.flight USING btree (flight_no);


--
-- Name: booking booking_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flight(flight_id) ON DELETE SET NULL;


--
-- Name: booking booking_passenger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES public.passenger(passenger_id);


--
-- Name: booking booking_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.bustrip(trip_id) ON DELETE SET NULL;


--
-- Name: payment payment_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT CREATE ON SCHEMA public TO admin_role;


--
-- PostgreSQL database dump complete
--

