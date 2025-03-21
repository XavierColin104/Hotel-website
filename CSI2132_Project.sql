PGDMP  %    2                }           postgres    17.4    17.4 7    z           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            {           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            |           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            }           1262    5    postgres    DATABASE     n   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';
    DROP DATABASE postgres;
                     postgres    false            ~           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    4989            �            1259    16496    Archive    TABLE     E   CREATE TABLE public."Archive" (
    "Archive_ID" integer NOT NULL
);
    DROP TABLE public."Archive";
       public         heap r       postgres    false            �            1259    16550    Book    TABLE     �   CREATE TABLE public."Book" (
    "Start_Date" date,
    "End_Date" date,
    "Room_ID" integer NOT NULL,
    "Cust_ID" integer NOT NULL,
    "Archive_ID" integer NOT NULL
);
    DROP TABLE public."Book";
       public         heap r       postgres    false            �            1259    16501    Checking_Renting    TABLE     �   CREATE TABLE public."Checking_Renting" (
    "Emp_SIN" integer NOT NULL,
    "Start_Date" date,
    "End_Date" date,
    "Pay_ID" integer NOT NULL,
    "Customer_SIN" integer NOT NULL,
    "Room_ID" integer NOT NULL,
    "Archive_ID" integer NOT NULL
);
 &   DROP TABLE public."Checking_Renting";
       public         heap r       postgres    false            �            1259    16475    Customer    TABLE       CREATE TABLE public."Customer" (
    "Cust_ID" integer NOT NULL,
    "Name" character varying(100),
    "Address" character varying(255),
    "DateAccountCreation" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "ID_Type" character varying(50)
);
    DROP TABLE public."Customer";
       public         heap r       postgres    false            �            1259    16481    Employee    TABLE     �   CREATE TABLE public."Employee" (
    "Emp_SIN" integer NOT NULL,
    "Name" character varying(100),
    "Role" character varying(50),
    "Address" character varying(255),
    "Hotel_ID" integer
);
    DROP TABLE public."Employee";
       public         heap r       postgres    false            �            1259    16452    Hotel    TABLE     {  CREATE TABLE public."Hotel" (
    "Hotel_ID" integer NOT NULL,
    "EmailAddresses" character varying(100),
    "Address" character varying(255),
    "NumberOfRooms" integer,
    "Rating" integer,
    "PhoneNumbers" character varying(20),
    "HotelChain_ID" integer,
    "Manager_ID" integer,
    CONSTRAINT "Hotel_Rating_check" CHECK ((("Rating" >= 1) AND ("Rating" <= 5)))
);
    DROP TABLE public."Hotel";
       public         heap r       postgres    false            �            1259    16447 
   HotelChain    TABLE       CREATE TABLE public."HotelChain" (
    "HotelChain_ID" integer NOT NULL,
    "Hotel_Name" character varying(100),
    "PhoneNumbers" character varying(20),
    "HeadOfficeAddress" character varying(255),
    "TotalHotels" integer,
    "EmailAddresses" character varying(100)
);
     DROP TABLE public."HotelChain";
       public         heap r       postgres    false            �            1259    16531    Manager    TABLE     t   CREATE TABLE public."Manager" (
    "Manager_ID" integer NOT NULL,
    "Emp_SIN" integer,
    "Hotel_ID" integer
);
    DROP TABLE public."Manager";
       public         heap r       postgres    false            �            1259    16491    Payment    TABLE     ]   CREATE TABLE public."Payment" (
    "Pay_ID" integer NOT NULL,
    "Amount" numeric(10,2)
);
    DROP TABLE public."Payment";
       public         heap r       postgres    false            �            1259    16463    Room    TABLE     �   CREATE TABLE public."Room" (
    "Room_ID" integer NOT NULL,
    "Amenities" character varying(255),
    "Problems" character varying(255),
    "Capacity" integer,
    "Extendable" boolean,
    "View" character varying(100),
    "Hotel_ID" integer
);
    DROP TABLE public."Room";
       public         heap r       postgres    false            �            1259    16573    availableroomsperarea    VIEW     B  CREATE VIEW public.availableroomsperarea AS
 SELECT h."Address" AS area,
    count(r."Room_ID") AS availablerooms
   FROM ((public."Room" r
     JOIN public."Hotel" h ON ((r."Hotel_ID" = h."Hotel_ID")))
     LEFT JOIN public."Book" b ON ((r."Room_ID" = b."Room_ID")))
  WHERE (b."Room_ID" IS NULL)
  GROUP BY h."Address";
 (   DROP VIEW public.availableroomsperarea;
       public       v       postgres    false    219    218    226    219    218            �            1259    16578    totalroomcapacityperhotel    VIEW     �   CREATE VIEW public.totalroomcapacityperhotel AS
 SELECT h."Hotel_ID",
    h."Address",
    sum(r."Capacity") AS totalcapacity
   FROM (public."Room" r
     JOIN public."Hotel" h ON ((r."Hotel_ID" = h."Hotel_ID")))
  GROUP BY h."Hotel_ID", h."Address";
 ,   DROP VIEW public.totalroomcapacityperhotel;
       public       v       postgres    false    219    218    218    219            t          0    16496    Archive 
   TABLE DATA           1   COPY public."Archive" ("Archive_ID") FROM stdin;
    public               postgres    false    223   �H       w          0    16550    Book 
   TABLE DATA           ^   COPY public."Book" ("Start_Date", "End_Date", "Room_ID", "Cust_ID", "Archive_ID") FROM stdin;
    public               postgres    false    226   �H       u          0    16501    Checking_Renting 
   TABLE DATA           �   COPY public."Checking_Renting" ("Emp_SIN", "Start_Date", "End_Date", "Pay_ID", "Customer_SIN", "Room_ID", "Archive_ID") FROM stdin;
    public               postgres    false    224   I       q          0    16475    Customer 
   TABLE DATA           d   COPY public."Customer" ("Cust_ID", "Name", "Address", "DateAccountCreation", "ID_Type") FROM stdin;
    public               postgres    false    220   0I       r          0    16481    Employee 
   TABLE DATA           V   COPY public."Employee" ("Emp_SIN", "Name", "Role", "Address", "Hotel_ID") FROM stdin;
    public               postgres    false    221   �I       o          0    16452    Hotel 
   TABLE DATA           �   COPY public."Hotel" ("Hotel_ID", "EmailAddresses", "Address", "NumberOfRooms", "Rating", "PhoneNumbers", "HotelChain_ID", "Manager_ID") FROM stdin;
    public               postgres    false    218   �J       n          0    16447 
   HotelChain 
   TABLE DATA           �   COPY public."HotelChain" ("HotelChain_ID", "Hotel_Name", "PhoneNumbers", "HeadOfficeAddress", "TotalHotels", "EmailAddresses") FROM stdin;
    public               postgres    false    217   aL       v          0    16531    Manager 
   TABLE DATA           H   COPY public."Manager" ("Manager_ID", "Emp_SIN", "Hotel_ID") FROM stdin;
    public               postgres    false    225   mM       s          0    16491    Payment 
   TABLE DATA           7   COPY public."Payment" ("Pay_ID", "Amount") FROM stdin;
    public               postgres    false    222   �M       p          0    16463    Room 
   TABLE DATA           r   COPY public."Room" ("Room_ID", "Amenities", "Problems", "Capacity", "Extendable", "View", "Hotel_ID") FROM stdin;
    public               postgres    false    219   �M       �           2606    16500    Archive Archive_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Archive"
    ADD CONSTRAINT "Archive_pkey" PRIMARY KEY ("Archive_ID");
 B   ALTER TABLE ONLY public."Archive" DROP CONSTRAINT "Archive_pkey";
       public                 postgres    false    223            �           2606    16554    Book Book_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY ("Room_ID", "Cust_ID", "Archive_ID");
 <   ALTER TABLE ONLY public."Book" DROP CONSTRAINT "Book_pkey";
       public                 postgres    false    226    226    226            �           2606    16505 &   Checking_Renting Checking_Renting_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Checking_Renting"
    ADD CONSTRAINT "Checking_Renting_pkey" PRIMARY KEY ("Emp_SIN", "Pay_ID", "Customer_SIN", "Room_ID", "Archive_ID");
 T   ALTER TABLE ONLY public."Checking_Renting" DROP CONSTRAINT "Checking_Renting_pkey";
       public                 postgres    false    224    224    224    224    224            �           2606    16480    Customer Customer_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY ("Cust_ID");
 D   ALTER TABLE ONLY public."Customer" DROP CONSTRAINT "Customer_pkey";
       public                 postgres    false    220            �           2606    16485    Employee Employee_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY ("Emp_SIN");
 D   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_pkey";
       public                 postgres    false    221            �           2606    16451    HotelChain HotelChain_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public."HotelChain"
    ADD CONSTRAINT "HotelChain_pkey" PRIMARY KEY ("HotelChain_ID");
 H   ALTER TABLE ONLY public."HotelChain" DROP CONSTRAINT "HotelChain_pkey";
       public                 postgres    false    217            �           2606    16457    Hotel Hotel_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Hotel"
    ADD CONSTRAINT "Hotel_pkey" PRIMARY KEY ("Hotel_ID");
 >   ALTER TABLE ONLY public."Hotel" DROP CONSTRAINT "Hotel_pkey";
       public                 postgres    false    218            �           2606    16537    Manager Manager_Emp_SIN_key 
   CONSTRAINT     _   ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_Emp_SIN_key" UNIQUE ("Emp_SIN");
 I   ALTER TABLE ONLY public."Manager" DROP CONSTRAINT "Manager_Emp_SIN_key";
       public                 postgres    false    225            �           2606    16539    Manager Manager_Hotel_ID_key 
   CONSTRAINT     a   ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_Hotel_ID_key" UNIQUE ("Hotel_ID");
 J   ALTER TABLE ONLY public."Manager" DROP CONSTRAINT "Manager_Hotel_ID_key";
       public                 postgres    false    225            �           2606    16535    Manager Manager_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_pkey" PRIMARY KEY ("Manager_ID");
 B   ALTER TABLE ONLY public."Manager" DROP CONSTRAINT "Manager_pkey";
       public                 postgres    false    225            �           2606    16495    Payment Payment_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY ("Pay_ID");
 B   ALTER TABLE ONLY public."Payment" DROP CONSTRAINT "Payment_pkey";
       public                 postgres    false    222            �           2606    16469    Room Room_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Room"
    ADD CONSTRAINT "Room_pkey" PRIMARY KEY ("Room_ID");
 <   ALTER TABLE ONLY public."Room" DROP CONSTRAINT "Room_pkey";
       public                 postgres    false    219            �           1259    16571    idx_book_cust    INDEX     E   CREATE INDEX idx_book_cust ON public."Book" USING btree ("Cust_ID");
 !   DROP INDEX public.idx_book_cust;
       public                 postgres    false    226            �           1259    16570    idx_hotel_hotelchain    INDEX     S   CREATE INDEX idx_hotel_hotelchain ON public."Hotel" USING btree ("HotelChain_ID");
 (   DROP INDEX public.idx_hotel_hotelchain;
       public                 postgres    false    218            �           1259    16572    idx_room_hotel    INDEX     G   CREATE INDEX idx_room_hotel ON public."Room" USING btree ("Hotel_ID");
 "   DROP INDEX public.idx_room_hotel;
       public                 postgres    false    219            �           2606    16565    Book Book_Archive_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_Archive_ID_fkey" FOREIGN KEY ("Archive_ID") REFERENCES public."Archive"("Archive_ID");
 G   ALTER TABLE ONLY public."Book" DROP CONSTRAINT "Book_Archive_ID_fkey";
       public               postgres    false    226    223    4802            �           2606    16560    Book Book_Cust_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_Cust_ID_fkey" FOREIGN KEY ("Cust_ID") REFERENCES public."Customer"("Cust_ID");
 D   ALTER TABLE ONLY public."Book" DROP CONSTRAINT "Book_Cust_ID_fkey";
       public               postgres    false    4796    220    226            �           2606    16555    Book Book_Room_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_Room_ID_fkey" FOREIGN KEY ("Room_ID") REFERENCES public."Room"("Room_ID");
 D   ALTER TABLE ONLY public."Book" DROP CONSTRAINT "Book_Room_ID_fkey";
       public               postgres    false    4793    219    226            �           2606    16521 1   Checking_Renting Checking_Renting_Archive_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Checking_Renting"
    ADD CONSTRAINT "Checking_Renting_Archive_ID_fkey" FOREIGN KEY ("Archive_ID") REFERENCES public."Archive"("Archive_ID");
 _   ALTER TABLE ONLY public."Checking_Renting" DROP CONSTRAINT "Checking_Renting_Archive_ID_fkey";
       public               postgres    false    223    224    4802            �           2606    16511 3   Checking_Renting Checking_Renting_Customer_SIN_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Checking_Renting"
    ADD CONSTRAINT "Checking_Renting_Customer_SIN_fkey" FOREIGN KEY ("Customer_SIN") REFERENCES public."Customer"("Cust_ID");
 a   ALTER TABLE ONLY public."Checking_Renting" DROP CONSTRAINT "Checking_Renting_Customer_SIN_fkey";
       public               postgres    false    220    224    4796            �           2606    16506 .   Checking_Renting Checking_Renting_Emp_SIN_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Checking_Renting"
    ADD CONSTRAINT "Checking_Renting_Emp_SIN_fkey" FOREIGN KEY ("Emp_SIN") REFERENCES public."Employee"("Emp_SIN");
 \   ALTER TABLE ONLY public."Checking_Renting" DROP CONSTRAINT "Checking_Renting_Emp_SIN_fkey";
       public               postgres    false    4798    224    221            �           2606    16516 -   Checking_Renting Checking_Renting_Pay_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Checking_Renting"
    ADD CONSTRAINT "Checking_Renting_Pay_ID_fkey" FOREIGN KEY ("Pay_ID") REFERENCES public."Payment"("Pay_ID");
 [   ALTER TABLE ONLY public."Checking_Renting" DROP CONSTRAINT "Checking_Renting_Pay_ID_fkey";
       public               postgres    false    222    224    4800            �           2606    16526 .   Checking_Renting Checking_Renting_Room_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Checking_Renting"
    ADD CONSTRAINT "Checking_Renting_Room_ID_fkey" FOREIGN KEY ("Room_ID") REFERENCES public."Room"("Room_ID");
 \   ALTER TABLE ONLY public."Checking_Renting" DROP CONSTRAINT "Checking_Renting_Room_ID_fkey";
       public               postgres    false    219    4793    224            �           2606    16486    Employee Employee_Hotel_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_Hotel_ID_fkey" FOREIGN KEY ("Hotel_ID") REFERENCES public."Hotel"("Hotel_ID");
 M   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_Hotel_ID_fkey";
       public               postgres    false    221    218    4790            �           2606    16458    Hotel Hotel_HotelChain_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Hotel"
    ADD CONSTRAINT "Hotel_HotelChain_ID_fkey" FOREIGN KEY ("HotelChain_ID") REFERENCES public."HotelChain"("HotelChain_ID");
 L   ALTER TABLE ONLY public."Hotel" DROP CONSTRAINT "Hotel_HotelChain_ID_fkey";
       public               postgres    false    217    218    4788            �           2606    16540    Manager Manager_Emp_SIN_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_Emp_SIN_fkey" FOREIGN KEY ("Emp_SIN") REFERENCES public."Employee"("Emp_SIN");
 J   ALTER TABLE ONLY public."Manager" DROP CONSTRAINT "Manager_Emp_SIN_fkey";
       public               postgres    false    225    4798    221            �           2606    16545    Manager Manager_Hotel_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_Hotel_ID_fkey" FOREIGN KEY ("Hotel_ID") REFERENCES public."Hotel"("Hotel_ID");
 K   ALTER TABLE ONLY public."Manager" DROP CONSTRAINT "Manager_Hotel_ID_fkey";
       public               postgres    false    225    4790    218            �           2606    16470    Room Room_Hotel_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Room"
    ADD CONSTRAINT "Room_Hotel_ID_fkey" FOREIGN KEY ("Hotel_ID") REFERENCES public."Hotel"("Hotel_ID");
 E   ALTER TABLE ONLY public."Room" DROP CONSTRAINT "Room_Hotel_ID_fkey";
       public               postgres    false    219    4790    218            t      x�3300�2300�\1z\\\ #�      w   @   x�E��  ��좩��2�?���~��qT�j���Q���y�a�)D!
1�'ZB.�B�� ���      u      x������ � �      q   �   x�Eͻ
1��z�� �2{���M�(
ka3j`c"����j8����������C��� �EX+�ޠ������A��pf�OL��D-��G/���pq���
�mI�%���.�qy�~@��I�C˳ׅ�C��4T��Ł���WƘ/��1�      r   �   x�]��jA�s�)� K�u�\E���z(/a;a�Df���Yh/=��K�t޷����5�|/b*���4R)�������_����|��ݾ3��w��d6N�?��u[z�?����	�q�O�ܬ+�f��3%�~�0��4��k��KT���/g�������G�}.t�Blpw�+wysν �G0      o   �  x�m��n�0����8��g{wK3ЮVݰ��bc�TXNѼ�(*�y��q�C����`/���y���\nw�{c;3M�����h�B��.W8��g����3\l�p{��@��4�0��s����Z�������XDK���)��X��mz߸ȋ���W�k8���/�"�mM��l{r�|�EJ�;?������~B�����
��o�ѥ�&�9����x�Ex�x�־�cJ"' Q�|�k,���{ߟ�v����;�-AH��ecH@Z��'�r�8�?�R�/�����h��Ƴ]��w��n3J>8ptPй3m>1��=>����8p����ε�M�oQ���'�_q�=���8{p)�e�Z�N�\!^]�.���"�f�)�jDk���y�c#ZͺR�-�_7Y��L!      n   �   x�-��n�@F����`������	jҦMLztō�c��ַ����3�Dи_��ݶ�℧Y΋r����a'�אN��Ge��V��� �'�=�vJ���gy�)A��m� FaBVoaR���</	����h��t��$i���T�a/�I�쥁.b��Y��)���6�؛�Z����'?�g��Bӄ#���P�jZ�(>����hK�ә X^�TI��Ⱦ0d�yI�x��L���|�� �wUh�      v      x������ � �      s   ,   x�3500�445�30�2500�420�3��9�lsS�=... ���      p   �   x��ϱ
�0����y�*��} -�u��t�5���B�H��4�$-��?>�B \���@ߕ�T �AIn�5��@�BȈ�i��]�+���>̐p�����{�:��F�<��y�f5&����,?��!rf���V���ࢂ����;�l�[���E�f�{��f�     