Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE4298651
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 06:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768311AbgJZFXB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 01:23:01 -0400
Received: from sonic308-37.consmr.mail.bf2.yahoo.com ([74.6.130.236]:42027
        "EHLO sonic308-37.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1768309AbgJZFXA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 01:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603689778; bh=/bo8v3BMH/9rh3bPl00fJ+9J/73oMLfrHfwFRSbRykQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ISO5BHri2rHVm+TvFW1IyK/X1QqiGvxSabkyHrUBGW/bu5uO50T3ekqi2553pGQ+EGvqcJxF+/c2TS/mEJelV3XQWm54E+zjcRZkrJULXnRrB0UXdsfu1V721ISV8kurvnZMgJg8gPXflYQVUpcrg9MC/CajtlscIPqCS60hrWmPpL+xiq0vMKGH67Sxgar5dTxOCR93liI0U1TEbCi3DLyqjMB6XTcishVvOc3fBIWZzxwCeAT0r4GQKUpa2wHzOPdKwMsWIzU7O25sayR2+fepMwTOn4Dcs5x0/haKs1Cm9Nb0uMXGyjNQ6rh8T4tbVT//MSrp6LS5S4mnDJ9vMg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603689778; bh=DqfLZi0vb845IDbGLr/NadkglPuZdjFx5yLifHcB/RN=; h=Date:From:Subject; b=sGj1A6k1SBcYRj14v/jwEUk/Z6yvrdCZcWnyNaj2oz53pp/RYJIVtX9oZPe8uLy8vkhXKvbppYe3RmjIYPbNib/4KCeuV34q4itcvOFS6v3+PoeQXy36OJkdPDiSON6mY8Pm45JL2ZOFG8vpqrkeoCDPRHTlETT7Gjufz5csMWIgy3mOuMTbCU2+5Tde25P+qpsw2k3SPk9uNClIX30WltV6Um2Ycril2ik43e1aAlMca0FJDk90ahB0uK6WqSlV9wJeQ2yR0uNue/+yoSyfphjXfk3ei8i0+3XJCwgUPMhqJBsXvy1axLefpfZJakzj444HTm6ZrlI+QIaQJLIpBA==
X-YMail-OSG: UwMQcEoVM1mexPsr3RLvdznYGSglz_PXTv5YuEUqEhvcGZ2ubIPBVLvtnKjtNmP
 wfaphTndqE6tUXh9i7hmwyp4xSaPhV_U2jzkGajV_qLPZ.DCeiLvInC4XzTqwpLj7dTU1MQhhMbN
 J5etK6qb6NCLA5aVyqRLkqgnqtNjSrQP9Krrgx3XgrHBW__Hp12T_iR5l85CfOTQ5.kKdzi_RtId
 fFruCWd7GememlF6UDYY3FAajlLatCslgLXDf92QzlmXcBsXpixQgH2n8WM0mnc5MdHuMWxBqhz3
 LeJBZuEges510WfjUIOQw.8ufJ6Wt2tLX2KEK5bLTXXdsT_z5Zrm2V_3Hnd0xv7oECYTZyOw1RuR
 C1SpCiDZTv.HpcB1bkLITKuf1utjSovjfNwVHeuiIzI.DIu.gyTp5IsPlsdO09GXXt1l606sJv9w
 w1xY2DVogyaCyIJMbsBgC_mYQIwxWPRnyqw6AUEX1OTsGnnx3AlpJA4.csfdob3xXbxFplTVzQ2B
 59PZ4AqqtHJbl7Oyadz6E_hmbHc9_KBab_BcclGLQEU7BvXvh8WvKar_QJ2sNIeOrG2mvxTwmIe7
 Ow0jydgGH3xq9LpVJQeNs0Y_OHKtSmWMQZWQNMqPUCk2HLxnPQahDdC9QpnrR4_uDGvwAB1tQ7Tp
 kEyxKc9AQhM21hapcIYvtRK_qyWdfKshVg.aVfmmMKoYGw6vkghujFOmSDL3iL5MgR50jjXQ1xG5
 rl_VDBTVJGd1YEsxQN6IXPg8m6aCW_ckEDBUd0VAhGwVlo9iiR9bPyhKvvL5JlgS7krOtqf2vUgN
 hZ_mSwPUOYsrXTChP_pmPDTnqXCLt4u0Ntv1ne5MjeChCDR8_LXYGYqGtNghJRDjTLMQcLQZ26fj
 H1RjwAitch0P0WmIvE349EzJH.rFnAxWdutv5SCdz1CP8iN_7RO3OSk0LTLc0gcVNjSkmIqtDiQf
 8BN89mdjCIoKv7ZBTJ8ywDrgkj3yl.I7W7OZU5ln7Nw_poUotCuyRaTV6.5AphBle40aX6l.ksTt
 LoaVeA4KLkj7WSHaP0HjsKw1DOErh5shE2U.TaNKPCigw2.52ktLR8DNevahg2vJ4cSDM3B4.5Us
 _WwTEURfyQRi3rahQhMUBGtC_7U8Ix_b..aZKvRkLOFM8kgM_7IKA31iyAa0cMcgPrDfdIl1vPPa
 NKTVDRMYoHPEeNzxSQzwBDZ_SOLGT57KLi6F0kqBVGxe3S2pkHe.7t6I6OuPF12YFHZ3jOnsn05y
 eDmEhD3jgSxVfvxNe2Bv2JfTNf3pF.jSmo5.YBJJRX5erPZOaE1t7CVP9r.Cl6Dfq_Yi6PaywqKF
 fKuol8QommJC6bhfGI5z0HAN79.dhg6n17stxfW9DofbDbv3RD1XFwrj3bqMjwIwoXuM9yqy.R8T
 avx2PT.XoKjoYumXp.CCD2QW1v.xICvCFW7t7Dhbj.npO_Q_4lAzRk5gZXwF5Rf5QVloxk2T1H88
 K0m49tpi3IhvRdkCO.GDLI8glrwvbwSrTuvnHBqey.eHf158Bn1A4Z66MJoVOC3vus8W2YfmorzD
 HHzspqo548HB4bkHQ6v51G.2XlV3PdlRIfmTO.OMzk5KcYWygp5IKNLxLiYRSVZhvlgbR_zVg.pm
 L9Eg_ZnJwbLm2DUGkP.euqCUaZERFQtfmBczIRdWbEdnBUBfcP3hD_TT_O3pYcovm5qD8NPV_yau
 D7sWyTvAsAXVgFMJY8I4sOsw6nxBVAS8PDYxS9tb84B9WE5WEzJ1otrBzaaJTNIVoTVcUcwxDmMW
 u.0Z4oM6qWtw6cJpKQZFB7EBbsa9Dm15B7bLTwSEhHlni9SxB2vH40Eztm.styJSC5VkTbFKENAc
 AsqNHonQNpY4udedzwssaasDMr1RrP1RXbq8aZNTwGu23TxgYW_TnXccvuMrI7vDmqVMg4IZDw8t
 N0n9udZWNY1pHAQl1i9w01d1LtLyhTZGKEfIIQgN3wh4Uaf0MN5Udw0aKJNDkZ9hubPJMfeyVu.3
 fvl21GhfhicReyxQ9oUYLsYyNXp8GjinlIc6B0CPa7QqptszjPyVsEtNTioH9o9yPJ0.V9E27MjV
 DdWf_anevDBO4kAgpNjUzAu.cVi72GJFkxcJdH9cjxNH5g91OVQkq17qor9w5wOFoprp7h6vK7wR
 NS..uVcznuK9MMEoP3d0p1K9lKkjN.i.pDCtPe2kPpGVfM9Z_D2M1nqTW82p._TN_bMlChO.6NcA
 KWCStqik4mk1WnnUafHGttIGTGJ07EreohWHR3jaOUGylDwkUlWZU6UQlR3ghYkAQmXI5AWqNOoq
 DwpPIkGCQc6pldWFKlIATzdjPEprhzn0b8ELgFwlI29ZaxTkumyCznatPBzD4HkvaqtL4mcRcOim
 hOC2aqojuGhWYltI2Lf2Z6nhaVjW1LBi_T6dIhrtQdzD0WExosVbszYV.s.78L0V4PCtj22m_2vx
 kVcYJCpw_9yxmOT86gt08nfzw9fLzI._omFHBs9nvQ70dh0dK6UQ8A69G7rDIpx3YmbZ7BMmurJq
 GgED.5yT1no8IxYpbB55dkPR2oTw_AWh9H1ArJOVsoTSsIz3ZVfpB4Rl1Jygoe3kfUHKyYMKjPi_
 0QfvSg_ZXE_hCJKetBp0AH.hVQw1jHXiM1BYGNdK_ngziDQUb8doJOKapvoYofWurnrpodgrPgQd
 91VktuCKwLRDhOAHeFvbhReO2zK4P7MJRIVx0jYmj378a9Oim2TkgVhkbAc0IZYlERfIH2JYcU3G
 4NkY2Rd6ohFK8pSTuSUck4xsEZKKoAdfW5AzEV369QTDN0QRHrOBKV4l22NH6T_nXTH8PhZqs9ci
 l39hROQnR_43JDDHYfhSARnAX2oNg7SIo286C44zr5H2SQuZ7U5obp9sCSyCRVi8Ir5cgpeqrbg8
 K4wNl..N4k7GyVPkBTwCeNV5j.I5nDhO41LE4JfGCttculDok2r6ZOcxRVpUprgYg0NhDsg3YdQZ
 NCFJ4SOoh4zuWQGHnrHQsYsCOOU6HJlGN7AOFIncyrHqOONW_.b_cmUpj7CeB9LOzHiFc1kvsnYS
 m49INMglncxGBYEYj4ieQNtTpEzNXl502133E0nxXpH0nwoyXDJ.zQC1Cap6m8BTKe3SAq8QRQdV
 lTGourHRWSWYHgkq5Iwhc_3EoppGOwv2EE4t2UUTeKCmIrrL7jLUIdYRfn8BKtUbT5WMH9zl0YuA
 Q5hJuT3_pJ8HY5VdmjrfLT4r4ZbwiX2WKqcjjFdjoZRI.RW4MUHZ_EVniuizBSsAh2FLr.Eihv7G
 j.ni3KeYRnVmgncbBEosW73vw8JHffTAgm5XMXcV533dBtXRAJUFu6Gncc.Ju8SOXiKdGAM3PWX5
 mDjG9uJ5YVyx7MyPnfcxTBagDjfPy2ajt_t5ZfSOvR1JzmaiMdZuVxxUsMUJbHMRXZ5fa2bUj26H
 VNIR.NnifoG1pIkkq.6wUs6PcgzeJMLPg3N.znc9zTqdFB.QOTA0oRXGCDb_ZO7Qe7bBGgDS3bsO
 YxcpwoRwzMJMD2p749OQMCTAZxRwRVNPRuDMrM1niQg2z4HakAEM.ZcFRozB.QMlAOHDcgaKiBZ2
 YdqEE0FZRUkjp_f.pEUD1TEHpvACigaOWAx09qkkNRETWsJIVZz9c1CPIhqNkMT_v7qwGvzhZS7D
 FaGA3DSpkH76UfFWm.5d9NyGdZ56EJhqzvkFhabxk.WeuxoQWXlKOotPCbJMfWtBnpyFiuvgAcWm
 cqAokBk2BrFBbkGcIygUiPHGKih48qQv3IFOZT_e0HS3FOSeuCqlvQ7u6OmH6WmhqdZXQXmvfvjp
 4sG0cmJPcCvG6Rp2qhZG1Dmai6PGPf4auPs6Yks461xetFqWGL7vGXYCskpdBWSP0ldD6tbFksBp
 fQqckrDx3ryvkeeydLJmRKQxFTEbh9HmC1.o10esk1mCTZ1aUYtNsewnU4vExWRZgf2utHbCSCBP
 hpErnAYiwI9UmSIFtznlSVSnLreOO9FXJkgVQn9ScJ7Ez6oyZndO5jB32_gSgvRI62cPV_MU0FfN
 3pJ6PTOi7h74s2NyPhpmdUDnkbUrqKSTp97EtGQoWUg1EhzYdz1gpZrkMVGARcKL2ozEyfBpp_Yy
 .qce1PLcFFpb82w7HB0.04HzAh0aoiyiStYnxDLsY.IQQ2NHp3dm_bUvTLSad5MMK5lboOnYV1y4
 2AlFYjRmSu7ov9CnQNZdd4GCVvXRp2HN_FwvCJsKLuUNQiIVIoJ3ClFYuYAW2zUZCMSswFMDzpON
 K9IF6utHq0M1uD1o6kQSRuDmwSIyaeJ8481CdHcHYohHtQm8tIyyaOfWz8g2kbJrmlNszDf6QU0L
 Lk9tOKQfjh2gdVNA9j8gvwpEroTUaIRN80MvcfcVGTwHipwFFttuqrNDQ6zOP9QCgCC9wcBaSrsJ
 CCiVB.PD1Tl5f_6tLV_qng1Nf_b_epvxg5MSM17p._2Xxo7ekpaeMtPVLn37C6H8RVqbGcwG9sLS
 Q06EBeGWV3pkiN4wspaLf43zKs_fqKh9W0VXa3hGchbCeYD_D4YQnkKbbxmmlt1QKcWxMctDW_PQ
 twcTwJXXOf4yYfVZn9w3wwJ9QwTdziQ4ad2MdcljvMqAVw5EcjIWJfRgbtHUyeHOi1TiauyK820V
 cH4OU8_vsYujwgFkeUJIfQxmoSR7BnJoUrV8zym44Ymj4CYJTFi62GPN6_Lsi4ZnqbXnv_0JvFZ7
 1H9l9iykqfqZiyO5K9Em5Vu_43pYZ_klaMusuzJjN6N6bO_PlG4.gxm0Svpus.J6WWBmykHcd9x4
 o9tKlsJzHalLrqKrTeOUJLs_V3fxPHSRRpkPEj0Bsd5tu2kEjtfbXuU_ebWbj3CldlHOpGEjFiuJ
 fcY_5tcBtUarS4BLzEI.vxYJ2_fvBKiX1dPSr.PLhIzms6itVV2VN2wCYyMBgiM6VhUyPUurpTxa
 gqRT62N95GbvNnHxyDat90UX9gJ7Mrq5QPc_JI2b7uWHov.bcZqXYlU0wsYpQCJNUHtT_28ihEf0
 7Vi54vE3L2od94dnZ_Owhe9H0dWlhnDK7LGtaW3JOXwJYM99RR_.g9.nqza5sn.N9X_d8zqJjbTs
 sq5Ed4PM4bs891jUkoyoziZ_Uj6bbkP7.MC7BzIdUw_CaTZNvjSPiqtYDTHZ7r26iMP7qRpStQ29
 WqMaY7RgZ9xzMh5WL6rWBzWDRC2vQrE4YR6a.kGmzBl4AwrlBbHHZna9y9SUnx_858b5VMR3dYDv
 WpodheceT4aI1UpALHnkx9lLRIfeGGPy_BRNNnQcNllvjodF3_1pOkHPKjtr4i2Hq3Ai9TmST838
 QkRp59NZ2DEezQYu.do9Sa3QG2CJiL8cVkLsg40YAg0Ypfzom6HavZTGaWJLzsBxpsHgF4ggzbFN
 LyvL2oSXfKxGFhvAMgA7DjbaFcRwY58PCR5MGBhM3nM7pY6e9BBJbjJOVvKdcCN9yo_kGU77DP.i
 uKrN80OaDOPg8drUAgc6Z9ZotUV23B3iF6OI0CHSP4c5EI7HNG0rJvkAQ8iahNGv5TyG6uNZBzX3
 OHpoeM85lMmmBMStLFYr.nI7r_QB6pGUFQ3jAWcEJ8k0ZMS_75q1uIcGX6sRgMNiXWi_Og.Ux_Yc
 usqV8Gl8zjH.n3q49hwWr8nvU2pZ3qO32
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Mon, 26 Oct 2020 05:22:58 +0000
Date:   Mon, 26 Oct 2020 05:20:57 +0000 (UTC)
From:   Office File <office01@gfbo.in>
Reply-To: johnjohn00924000000@gmail.com
Message-ID: <1120460280.2496316.1603689657736@mail.yahoo.com>
Subject: COMPENSATION PAYMENT NOTICE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1120460280.2496316.1603689657736.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Dear Friend,

On a very happy note and bearing in mind the staunch commitment that you had put into the quest to see that the fund was transferred to you for claim as we had arranged but to no avail, I write to inform you that at last, the fund transfer had been a SUCCESS.

Since all our effort in conjunction with yours were met with various failures and disappointments, there was an influential party from Britain that was approached on our behalf by a Finance and Management Supports Initiatives(a consulting firm); and with her (the influential party) imputes, the Fund was paid out and I have collected my own share.Presently, I am in Japan where, in partnership with a core investor in the Mining Sector of their economy, we are investing in the industry.

But, I am not oblivious of the fact that you did your best in that context, although, it seems that element of doubt crept in. You were not to blame, as there were many circumstances that would reflect such skepticism to any reasonable being. For your sincere but unfruitful sacrifices, I pressured the influential woman to concede some amount as COMPENSATION to you, for the resource that you plunged even the time and inconveniences.

The sum of US$3.7M was what she agreed as your compensation value, and the sum was made in ATM VISA CARD but, because of my appointments and engagements in China, I could not get through to you since your number at any time indicated "not in use", I then handed it over to the Secretary of the Finance & Management Supports Initiatives, the consulting firm.

His name is Mr. John John and his email: (johnjohn00924000000@gmail.com) the Secretary is very much informed by me about you and I instructed him to hand over the ATM VISA CARD to you as soon as you contact him. I gave him the CODE 209, which you have to mention for identification.

Note that at times I will be in the site and the Internet does not work there, this means I can only read or reply to your mails only when I am in the city.

Yours Sincerely,
Mr David Williams
Chairman and CEO,
Offshore Group of Investors LTD
