Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312F613A901
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 13:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANMKD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 07:10:03 -0500
Received: from sonic303-2.consmr.mail.bf2.yahoo.com ([74.6.131.41]:36832 "EHLO
        sonic303-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANMKD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 07:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579003801; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LnPyXsWFrrXotIRAucZ0uuhK6nz1brScDLcYnG5tn9RdPSgF9HmwH1ourIUFzggDBvG9Xzp/a+GhUWlPueVHV7LTzWqASWx1bnIGh0NWuMZa9Bm4jG/n0XsIM/FvMOBLiYfw1snvu+5/OeaSJhwwYDtiBOKfHAqsak1y+1gv+511xW23TtpNfcUyyRwm5EMz0QV61BTdVq4Ys81YNCA+hnYk+7xbWquhAHYpLOb+aTJCVeP+/rlw7vsAmgCKaqfqwd/TW3cg0A3crfgcP27ACgw/p1PAdZdWp6q1anSnmzMmCqKEbtT6eQWJWPnEIXKLaana8GZvAIJaAmMFVMlgOg==
X-YMail-OSG: EH0j3w8VM1mzRkNYysQ4_TIDyjkSMV3orAqb7gVKXYZqTzfe_HtWXqqvg9cenox
 ZwfB.Hxki4PP5t_WEPWAUWioy4XX4A6urqVD616ERET5Dkm5.neAvG44hpFxfie8j3PA4am61wbC
 UvguD4qAx0xCWiFQSYuaWXiIpN_KoWMOC.IOVobWWIa2LEtTuVEbyZBHyqSSUQN6Km806x2BSXBA
 MB.tIT_Y_GnIGqwIySIpphhB09W.UFowpOdG4o5aPgEslWqRkajqPMnxbY9ZXWPzerXUhs7cVp7d
 hxkAj7hnqTI4gtOlg_DEsad5ZEmP_xfwC8n1ZuiRM6D2Vv4qPX67xcF.v6hNSmaGAP22lkaLGedO
 egEMLMFw4YCkXlGg5LWI2Jg9LE9wgEex58uP5m94bE1sUSKPSA5dr9B_VZs1CMEknpmuvWaWcxwk
 qEiX_Sg2cwYou3JYOhHkoCov07SX3lFCdeZ7HAnUWcrVILPklIz5WRYmJ.YIqxm3BqDyLCS4jtmA
 n33JtyhqplxHju1H6f3XIg93sbDwG.bzseSnvLqgzzf0G9bjjX4fZZqwTiHJjfDv0w9BBQz7HKPL
 Gsi7OtXeFqHlK0GUvIcbAiP0qIAkstH8gsU033dYy2QowI84M6LgB2BgMD23RRV2fbBOvcU4k1Jv
 51STuCCaGIyIXPnG9pEWzpA22Ap8vr8h10HlMKpgmZs_XFxjiTqudT0WTyPzchB.hZTmKrU0IKBI
 20wiTeITAfFDUtxojcwnIlkjdEkjsaz37HThyJeZ10IhqGNgIK.mzzg5VrR3J_LLWeYapx5DWZvt
 4kQ9ozzek_1PpE_U9I6lR_bLpLlvIDp66EFiTPSmQR8LafAEGvfYjmuUkq.L9sGdxd3YewGJHRUF
 RKppmWQeUCkRCxE8_B6r8JtNgmctc_oNibyyHmvoXj3.GYzduOGoL_495golEKjAH9erAp2GL4se
 0_7DkhoHXSf2v6S9wAaxiTpSQKK68pkvceYHgD3JMad.GNPIJRD_.GJXJepAe0Lf_QIvmHTf8TAz
 EjT68cEBfdND8RaWUUSY59iRSf.0t4YADpIfF2rg2nJWwHcNUy6.uZsp8HEbqe0zeuNMslcMud6W
 v5F8MANKdowhDFX8RitIAOSrqnXSrgFALas2PMThufkDAIMUc_fgpWSJxQKf1k22w3TQRd11tHTO
 _svE4pGTAkDpfOFuDKoPX3wlEZNevPZT6WR1sB8Uupx8RWu_p9N.QasPTznRzV0X9ywhfyxAva1Y
 h1tbsWmW482eQD59mUxpO5EOFbhvVkz_Ak.cjL_ImYBVB0nO6lvpktfYxHYDEMlN5vpOHI_yfpUL
 tnY4pQj3L4jphWlT4Vclh7qIiqyc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 Jan 2020 12:10:01 +0000
Date:   Tue, 14 Jan 2020 12:09:57 +0000 (UTC)
From:   Aisha Gaddafi <edwardben25@gmail.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <1506716641.7402230.1579003797790@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1506716641.7402230.1579003797790.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaddafia504@gmail.com)
