Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902AB181D9C
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2020 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgCKQSA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Mar 2020 12:18:00 -0400
Received: from sonic307-30.consmr.mail.bf2.yahoo.com ([74.6.134.229]:40970
        "EHLO sonic307-30.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730122AbgCKQR7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Mar 2020 12:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583943478; bh=S3FOFVZUCXKfYNwR68LIUeoh2UzhKu7X+maqzkwCi4s=; h=Date:From:Reply-To:Subject:References:From:Subject; b=J7avR1EpYdb4cHcTTW2zwnNDCs7mEpaClMJx1U4VXYTq3fFv+XZv/XIHhV8lt6iEj0ydc+wSykakROEaEEFGLPXCV6T46gjWdHM39eHM3FF4tA5VFOunQ0PpX6EpGo9tRsaY4WJM1h2rHCAsSyI+Xfp87LWEiuYN7Yh6vzcVSvO+EFInCKp+VMlv34s9vKq8yrFH8F/afQEz0cdTQ+hZnZfdNf+KgeSnI6dMTMyCO+VLAUvpJicpAWvu/ldDrUrKx1FH4khlGwMGFSzpyOe98xcs0jOMcGQPZsJ8zOrgHwbr2cbLpCgi8Expde739LyIDXRtfX6kGomYFnEM8FJ27g==
X-YMail-OSG: GjR8NMcVM1mEcDpQ_aGaCIWsarzy4jE.BtDPLMz7BxZF8ZuiQn0vPexe1U_7hK1
 lwwO3upSkyBzSYceUYOcadfGEGZ_HXTfR3uOVQ9gWOaGUrY0XPxCler0Kp.0CC0gZFzX8tl1ueWp
 kxxbN2bHM9tbMia53XohQJg_rBnHLx5b7DMMGPjxiw4Lh7ERUBgu.rO4IujfOcXXp.RGoCUa8vOr
 Wh6Y2hM3R0jHJpRizhmfi063wjYruJLoiinfraZN8hCfDmfcpwQWVPxLysOYgNF74SSdOv1I668B
 jZjuwrHQJQYg0RgPwkgtwiL1E.cZx5NTX7fPJSdohGzd3sdozgREw9rbe_33HgjJR0vzPLFmDPC4
 7EXfk4DQowfm8s.xE3zIC3dK7A5GmFe6IoVm0kFflQn_MPeoB3sM4muBhoa8LrQ9mDtTeiiCSsZM
 Wag2i.cKQxjhWhcPn44Z.OB3ovdzNTL6fiefHOeDM240qsYnKd9U3j34SrofdU2OUzY6qwclgjFD
 IAfnk_5_7kaiuIFyg2r2XoI_61gvpsvc6i2AH8PvCRziLpECnm6wUcq69Vlm0aiSq2TzNZJ29hHu
 LTmd0oRXoNWEM8ry1aV3GNv0yaKAV08kl0OrP39DV69eDh.L5gmee7dDRR2POpnxprn2DaJIH9xM
 pqewpIks2u3xWR29S0C2csXp7au_R6uZdL.v_cNLVyz.j5J5poawd5PCrngTHcSFmVYcHUu2JwFZ
 ix30kcmQNeYf1yzKb_K1UxjpogiauaiB2mThI_lAA9BPVc09h3cozufr.xVuWAx7vExR4ZDjdgBU
 896537hqeqSzV29GkrqxKgplXwbt9RyKf5iE87lQqklm7rOwumIhmCz6gPiLFt42ms.aWbO2K9Bq
 XFOkl2AP9uNiblMoE4qJI35G4Uj9kqycHgad.Dk.OuY3jIog0H7KQkTKDo53AD3R7DwU1ouyeYIB
 0i6VDPq3yKUcbqaBqH0E_BkgPZSt0Nnh0RMuWWCSqlSFawt9s0U.tuM_Xw8.gTnpGSrJBO35Z2Rm
 lxc3q4RgRtePDPugCqet_kh5elrHBxSQhO7QPp8.n0YCwBuARxLYM75IrXSbNv62eAuHx0JWKdmA
 mdaX7hwE5cO13eN87oHJbJXoyrf9hg1XPrnEUGFd6PJHCcwlO0uojCYzNJ_0HjTq7ij.w3RqMMw1
 3XweBwDZVgpxPDSZwn2WoLQlCpGSPcfuWY9tndrzPGeByq_lX0xkP1rAHRL90HcvSLLjngcoVJ02
 F_LOa0_WayoW6mR1NfrsTUl1iZC1asunu2hQfoBaamxBRMv19xfxUgH.qjC7WPQ0bUDKb4gA2SNP
 wxyOr9nEoTzaw7JK0CYqAMYtgvqyu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 11 Mar 2020 16:17:58 +0000
Date:   Wed, 11 Mar 2020 16:15:57 +0000 (UTC)
From:   Mark Joseph <markjoseph01000@gmail.com>
Reply-To: markjoseph0100@gmail.com
Message-ID: <388082792.2176480.1583943357259@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <388082792.2176480.1583943357259.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear=C2=A0Friend,

I=C2=A0am=C2=A0Mr.=C2=A0Mark=C2=A0Joseph=C2=A0a=C2=A0banker=C2=A0in=C2=A0Ou=
agadougou,=C2=A0Burkina=C2=A0Faso=C2=A0.I=C2=A0Discovered=C2=A0the=C2=A0sum=
=C2=A0of=C2=A0seven=C2=A0million,=C2=A0two=C2=A0hundred=C2=A0thousand=C2=A0=
dollars=C2=A0(usd7.2)=C2=A0belonging=C2=A0to=C2=A0a=C2=A0deceased=C2=A0cust=
omer=C2=A0of=C2=A0this=C2=A0bank=C2=A0the=C2=A0fund=C2=A0has=C2=A0been=C2=
=A0lying=C2=A0in=C2=A0a=C2=A0suspense=C2=A0account=C2=A0without=C2=A0anybod=
y=C2=A0coming=C2=A0to=C2=A0put=C2=A0claim=C2=A0over=C2=A0the=C2=A0money=C2=
=A0since=C2=A0the=C2=A0account=C2=A0late=C2=A0owner=C2=A0from=C2=A0Lebanese=
=C2=A0who=C2=A0was=C2=A0involved=C2=A0in=C2=A0terrorist=C2=A0attacks=C2=A0i=
n=C2=A0month=C2=A0of=C2=A0January=C2=A015th=C2=A02016.

Therefore,=C2=A0I=C2=A0am=C2=A0soliciting=C2=A0for=C2=A0your=C2=A0assistanc=
e=C2=A0to=C2=A0come=C2=A0forward=C2=A0as=C2=A0the=C2=A0next=C2=A0of=C2=A0ki=
n.=C2=A0I=C2=A0have=C2=A0agreed=C2=A0that=C2=A040%=C2=A0of=C2=A0this=C2=A0m=
oney=C2=A0will=C2=A0be=C2=A0for=C2=A0you=C2=A0as=C2=A0the=C2=A0beneficiary=
=C2=A0respect=C2=A0of=C2=A0the=C2=A0provision=C2=A0of=C2=A0your=C2=A0accoun=
t=C2=A0and=C2=A0service=C2=A0rendered,=C2=A060%=C2=A0will=C2=A0be=C2=A0for=
=C2=A0me.=C2=A0Then=C2=A0immediately=C2=A0the=C2=A0money=C2=A0transferred=
=C2=A0to=C2=A0your=C2=A0account=C2=A0from=C2=A0this=C2=A0bank,=C2=A0I=C2=A0=
will=C2=A0proceed=C2=A0to=C2=A0your=C2=A0country=C2=A0for=C2=A0the=C2=A0sha=
ring=C2=A0of=C2=A0the=C2=A0fund.=C2=A0=C2=A0If=C2=A0you=C2=A0think=C2=A0you=
=C2=A0are=C2=A0capable=C2=A0and=C2=A0will=C2=A0be=C2=A0committed=C2=A0to=C2=
=A0making=C2=A0this=C2=A0deal=C2=A0successes=C2=A0contact=C2=A0me=C2=A0thro=
ugh=C2=A0me=C2=A0for=C2=A0more=C2=A0details=C2=A0to=C2=A0confirm=C2=A0your=
=C2=A0interest.

Yours=C2=A0faithful,
Mr.=C2=A0Mark=C2=A0Joseph
