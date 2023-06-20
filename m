Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D867361E3
	for <lists+cgroups@lfdr.de>; Tue, 20 Jun 2023 05:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjFTDC7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 23:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFTDC2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 23:02:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D81BD1
        for <cgroups@vger.kernel.org>; Mon, 19 Jun 2023 20:01:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b46cfde592so35724611fa.0
        for <cgroups@vger.kernel.org>; Mon, 19 Jun 2023 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687230116; x=1689822116;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BrbG7JxveYysVe86t5gOLnlc9dkaosvcFTwxzJdTEvM=;
        b=Kf6bu6L4x5lzVBGRCdagk+XWCcWeD97KHAuE9tSb5aoYsnHyamttqunGIKsG4vnnyO
         C+ndqLWH+6AsikmtI5/qdUwd2H/05ciMWN0S1MVzX51r69HMr8rDo/KVgPRH7m98XrBl
         ORa4ZcUqWSekNXYF3kz3Y+g+drpmqkEsGckfPb1p1Z1XG89rkb4QhqTX2of9djnQjymi
         pSHiC632aijqE9GjXR/eQ4xg/w5JbetsC7UNTVkcjf96x+oD+j1phSKFf4QcfqM4ov4x
         fsOtzEsI64PtfD1dQgbixDkw63w/B3XrJ8FkaCzt5LZkE1Mj+JFJELvDg+xMSPcTE/27
         MOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687230116; x=1689822116;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrbG7JxveYysVe86t5gOLnlc9dkaosvcFTwxzJdTEvM=;
        b=HIQkVYVAmt+DLwZo+rlTClZqP83osAlysSQxn/6+J/Mop36nnVNQ5XtB1dubQUaPLc
         5GEGfEY1FjoDtdtIA0EywY7t0bmSmJSsbvgHXimnCw+Sjy4sk4z0p07qvlRmrh5ZC7tJ
         DNlnvqVOWv7kd4LlPzsAXtavaFXWSxoDzl8HPqSt0RKn+TzuGAgN98kn+wBo1y4fA9qe
         lOqXGWSKZpCqKL3mHSNhI5Y6x3LjZNqwOpMhqw+SfNBxVxcKhgXmqjJYVrbWLRHMcEnZ
         6PAdADRKWWfstOCRJuNVEVaEdpl0xt0+GJ4mRE+EszVjiQK2HyTL/RWfQmYj74NumQHp
         ICMA==
X-Gm-Message-State: AC+VfDxd3qbUC3xw6+WTCleBhCNFprAFvdGGptSaKGmqqXjSGYfyrdk/
        hnGPC1UvAwvqutGdALVJqvDplHPpqaPd8pNhzJk=
X-Google-Smtp-Source: ACHHUZ47jNU4wezvDRDndldRHfasabDWENMhXMFfOBu7H1Pts5CzW2qbhu7U+2ZrABW+bcztS498BueSQOsDqrGe5/g=
X-Received: by 2002:a2e:3210:0:b0:2b4:7559:32b0 with SMTP id
 y16-20020a2e3210000000b002b4755932b0mr3124285ljy.19.1687230115507; Mon, 19
 Jun 2023 20:01:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:4a90:b0:986:545c:2dc5 with HTTP; Mon, 19 Jun 2023
 20:01:55 -0700 (PDT)
From:   United Nations <cindylove276@gmail.com>
Date:   Mon, 19 Jun 2023 23:01:55 -0400
Message-ID: <CANHmF4BP8mwKLmoASmQz2zpk+kTQZ=yA1xdukOs=9JMTpxGK5g@mail.gmail.com>
Subject: Congratulations
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_3_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        MONEY_FORM,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cindylove276[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cindylove276[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_3_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

V=C3=A1=C5=BEen=C3=BD vlastn=C3=ADk e-mailu/p=C5=99=C3=ADjemce fondu,

Neodvolateln=C3=BD platebn=C3=AD p=C5=99=C3=ADkaz p=C5=99es western union

Byli jsme pov=C4=9B=C5=99eni gener=C3=A1ln=C3=ADm tajemn=C3=ADkem Organizac=
e spojen=C3=BDch n=C3=A1rod=C5=AF a
=C5=99=C3=ADd=C3=ADc=C3=ADm org=C3=A1nem m=C4=9Bnov=C3=A9 jednotky OSN, aby=
chom pro=C5=A1et=C5=99ili zbyte=C4=8Dn=C3=A9
zpo=C5=BEd=C4=9Bn=C3=AD platby doporu=C4=8Den=C3=A9 a schv=C3=A1len=C3=A9 v=
e v=C3=A1=C5=A1 prosp=C4=9Bch. B=C4=9Bhem na=C5=A1eho
vy=C5=A1et=C5=99ov=C3=A1n=C3=AD jsme se zd=C4=9B=C5=A1en=C3=ADm zjistili, =
=C5=BEe va=C5=A1e platba byla zbyte=C4=8Dn=C4=9B
zdr=C5=BEov=C3=A1na zkorumpovan=C3=BDmi =C3=BA=C5=99edn=C3=ADky banky, kte=
=C5=99=C3=AD se sna=C5=BEili p=C5=99esm=C4=9Brovat
va=C5=A1e prost=C5=99edky na jejich soukrom=C3=A9 =C3=BA=C4=8Dty.

Aby se tomu p=C5=99ede=C5=A1lo, bylo zabezpe=C4=8Den=C3=AD va=C5=A1ich fina=
n=C4=8Dn=C3=ADch prost=C5=99edk=C5=AF
zorganizov=C3=A1no ve form=C4=9B kontroln=C3=ADch =C4=8D=C3=ADsel p=C5=99ev=
odu pen=C4=9Bz (MTCN) v
Western Union, co=C5=BE v=C3=A1m umo=C5=BEn=C3=AD m=C3=ADt p=C5=99=C3=ADmou=
 kontrolu nad va=C5=A1imi
finan=C4=8Dn=C3=ADmi prost=C5=99edky prost=C5=99ednictv=C3=ADm Western Unio=
n. Tuto platbu
budeme sami sledovat, abychom se vyhnuli bezv=C3=BDchodn=C3=A9 situaci, kte=
rou
vytvo=C5=99ili =C3=BA=C5=99edn=C3=ADci banky.

Skupina Sv=C4=9Btov=C3=A9 banky a Mezin=C3=A1rodn=C3=AD m=C4=9Bnov=C3=BD fo=
nd (MMF) na va=C5=A1i platbu
vystavily neodvolatelnou platebn=C3=AD z=C3=A1ruku. Jsme v=C5=A1ak r=C3=A1d=
i, =C5=BEe v=C3=A1m
m=C5=AF=C5=BEeme ozn=C3=A1mit, =C5=BEe na z=C3=A1klad=C4=9B na=C5=A1eho dop=
oru=C4=8Den=C3=AD/pokyn=C5=AF; va=C5=A1e kompletn=C3=AD
finan=C4=8Dn=C3=AD prost=C5=99edky byly p=C5=99ips=C3=A1ny ve v=C3=A1=C5=A1=
 prosp=C4=9Bch prost=C5=99ednictv=C3=ADm
pen=C4=9B=C5=BEenky western union a western union v=C3=A1m bude pos=C3=ADla=
t =C4=8D=C3=A1stku p=C4=9Bt
tis=C3=ADc dolar=C5=AF denn=C4=9B, dokud nebude celkov=C3=A1 =C4=8D=C3=A1st=
ka kompenzace dokon=C4=8Dena.

Proto V=C3=A1m doporu=C4=8Dujeme kontaktovat:

pan=C3=AD Olga Martinezov=C3=A1
=C5=98editel platebn=C3=ADho odd=C4=9Blen=C3=AD
Glob=C3=A1ln=C3=AD obnova spot=C5=99ebitele
Podpora operac=C3=AD Fcc
E-mailov=C3=A1 adresa: (olgapatygmartinez@fastservice.com)

Kontaktujte ji nyn=C3=AD a =C5=99ekn=C4=9Bte j=C3=AD, aby v=C3=A1m poradila=
, jak obdr=C5=BEet prvn=C3=AD
platbu. Jakmile s n=C3=AD nav=C3=A1=C5=BEete kontakt, nasm=C4=9Bruje v=C3=
=A1s, co m=C3=A1te d=C4=9Blat, a
p=C5=99es Western Union budete dost=C3=A1vat =C4=8D=C3=A1stku p=C4=9Bt tis=
=C3=ADc dolar=C5=AF (5000
dolar=C5=AF) denn=C4=9B, dokud nebude celkov=C3=A1 =C4=8D=C3=A1stka dokon=
=C4=8Dena.

Kdy=C5=BE ji budete kontaktovat, m=C4=9Bli byste ji kontaktovat se sv=C3=BD=
mi =C3=BAdaji,
jak je uvedeno n=C3=AD=C5=BEe:

1. Va=C5=A1e cel=C3=A9 jm=C3=A9no:
2. Va=C5=A1e adresa:
3. V=C3=A1=C5=A1 v=C4=9Bk:
4. Povol=C3=A1n=C3=AD:
5. Telefonn=C3=AD =C4=8D=C3=ADsla:
6. Zem=C4=9B:

Pozn=C3=A1mka: Doporu=C4=8Dujeme v=C3=A1m, abyste pan=C3=AD Olze Martinezov=
=C3=A9 poskytli
spr=C3=A1vn=C3=A9 a platn=C3=A9 =C3=BAdaje. Bu=C4=8Fte tak=C3=A9 informov=
=C3=A1ni, =C5=BEe va=C5=A1e celkov=C3=A1 =C4=8D=C3=A1stka
m=C3=A1 hodnotu 1 000 000 00 $. Gratulujeme.

Zpr=C3=A1va od prof=C3=ADka
Spojen=C3=A9 n=C3=A1rody
...................................................
Dear email owner/fund beneficiary,

Irrevocable payment order via western union

We have been authorized by the United Nations' secretary general, and
the governing body of the United Nations' monetary unit, to
investigate the unnecessary delay on the payment recommended and
approved in your favor. During our investigation, we discovered with
dismay that your payment has been unnecessarily delayed by corrupt
officials of the bank who were trying to divert your funds into their
private accounts.

To forestall this, security for your funds was organized in the form
of money transfer control numbers (MTCN) in western union, and this
will enable only you to have direct control over your funds via
western union. We will monitor this payment ourselves to avoid the
hopeless situation created by the officials of the bank.

An irrevocable payment guarantee has been issued by the World Bank
group and the international monetary fund (IMF) on your payment.
However, we are happy to inform you that based on our
recommendation/instructions; your complete funds have been credited in
your favor through western union wallet, and western union will be
sending to you the sum of five thousand dollars per day until the
total compensation amount is completed.

You are therefore advised to contact:

Mrs. Olga Martinez
Director payment department
Global consumer reinstatement
Fcc operations support
Email address:  (olgapatygmartinez@naver.com)

Contact her now and tell her to advise you on how to receive your
first payment. As soon as you establish a contact with her, she will
direct you on what to do, and you will be receiving the sum of five
thousand dollars ($5000) via western union per day until the total sum
is completed.

When contacting her, you should contact her with your data as stated below:

1. Your full name:
2. Your address:
3. Your age:
4. Occupation:
5. Telephone numbers:
6. Country:

Note: you are advised to furnish Mrs. Olga Martinez with your correct
and valid details. Also be informed that your total sum is valued $1,
000, 000, 00. Congratulations.

Message from the pro
United Nations
