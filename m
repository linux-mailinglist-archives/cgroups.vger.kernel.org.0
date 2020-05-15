Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91601D5334
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEOPIy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 11:08:54 -0400
Received: from mout.web.de ([212.227.17.11]:53791 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgEOPIx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 May 2020 11:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589555313;
        bh=2Az8NnR7wJ9rN2x9fHizGYiaHCVrPmmewTwIZIfBU5s=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=ZXqvivJYAuG2fJlojZrSHhjwQJMqWniMoTMe+0INKTTnV58dM4Xixiq/5QBWDZMyb
         UuWu3I3Hwznw0mN1iaJ/pKKdSzfPsgGXwiZOvQzrM7OyVnVACMjAFuS87gZditjEN+
         qdVQ4/JD85kb8t11+KIeFoDLzVGDucar4JRBeb2A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.164.161]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOArg-1jU6AW37fY-005YVb; Fri, 15
 May 2020 17:08:32 +0200
To:     Wu Bo <wubo40@huawei.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Feilong Lin <linfeilong@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] blkcg: Fix memory leak in blkg_conf_prep()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4c670a6c-98c3-2b14-7438-09199506d92f@web.de>
Date:   Fri, 15 May 2020 17:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6zCR73WCJ+xsN9FSih8Z9jG+4rbMSSH93H8i/IOv2Je0OjMfyGL
 gMTBw3FdaTzbP0Bq0Zx6MC6lUmzzAzLij6ZyDsQu+HRUqVtXsLk94WRIYNNFngJZFzysEIx
 Y0czS7ob3NZ55bWZzX/jn9j2Uc0UG2nHPzZ2BgfaUWhjJm77ZZ1JVC6/KJoEIGnOC/w3wIV
 Ld0oBSoqKP7R/Za0EoyTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V4nh84CWi3w=:PU/8sCh+p7VyTbyebDcCCU
 9Ui/9Ggc12N8n5H/kSY8qHx6adZz0Zn8udibpHMPUVSMRxHT7g1ifarghHAhXx6G76++SMOxs
 189VwvtJjgCvXN0G6YEO6rs6ri5zsKB3RQf8buVohG/ZjO3OTkZGv4TRNO4B10o9f6nuZ1G2V
 Htd5UEqgqr5GRnXJMhPduqQoEQ5SQZ2wlGWeOnil8rnBY01ILN8LHuMwNwhg3flfdW9ZIzt0h
 ff8S6GBitend6XoVUw1hPanP0dqMM7k2HsZlx++gadSSHg4h4KN0wxDKR+gnuXr3k+SM4Yu48
 AIG1k5+VqT0CtIvlQOKPMAyNxSFpx6zXQn9VDXv1Uqy36F8O3Tzb+/puEVTc+gOo78IQmdfCC
 VYc5NH6DOAJIrewP/bFIZ3gP0IY6IzmDVNGogGNBJeUpq25CyB1Aw3QsNLSP33LmrC/6hI6Sl
 o6lpYuxKRokkUaxu6WHLS45DI2IKVYEwQdCpmQssC0WVBe+Jm5BE+ZKbm3OyoeR0bC4uMF9mS
 wsbNoy+9rRrB3+pQmN2WdLFf4Zm0By5yBLXYvrpmRwad8A6m5/lomK2hkVVtpH3jCJSINL4Q1
 YMPrfUCzf23N8EwrTtBWEHmC7GrCmYvY3xt/rnx3VWfyU8D8SYb6Om+J1wtMEvYIGC3A0M9xl
 DzSqgQpZrB1ulo5Wxf00xchOcacAhee+V0fZlsxCqZq3BBxoG1F7sPpARuZ531DNMF+1rFYoC
 5qcNBUK26tpkj0uOUCdpDVaK1dWxiSF+sXzXArnQcZymvo+eFOwGQArOHMNglGFJm1XPAHQZn
 sewfSOPSgZiHWo7WzPwB/AlymHm7i+6FJP8OvqEr5DCNVoxECqygYJN6uBGBaSXavtbQ2Fr/t
 M7cxx9F2aiOhScl+imSnnlQ0alXV4XTgcHTwbeRbN9tjEOuBxnsZ3jk0l9L2uwSG3f7ZeEmjq
 UZw+BLgF9JemuOJ9s08p4WV2vZ+150+2amWHQuJ1koZh2PdltPVock2TX8xSn8fbmMWE+XW4K
 JjbVFUjFKLiNMkjBk0VORIyty7Ixecm3+/t3kv+UcpghCyRyuoRmeqU4ZFwD6a1aAFB24lorl
 oacTKnNTDyKT6pBzsda4ZIJMUfWrvxEQg3RL5Mps2qUmVN0Cp0KvH3h0oQ/BjtUgjYGA6E/+k
 Q1LKyX1F07hymGx6sB7EYT2GexnRzm0UF8JcHQ0ev6IvQB3g1C7YGdLPfXPXsA43vnWcVUEy+
 NLj3TxcLTA8UsERUN
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

=E2=80=A6
> new_blkg =3D blkg_alloc(pos, q, GFP_KERNEL);
=E2=80=A6

I suggest to omit the source code quotation from the change description.


> if calling blkg_lookup_check() failed, at the IS_ERR block,
> the new_blkg should be free before goto lable fail_unlock
> in blkg_conf_prep() function.

How do you think about a wording variant like the following?

  If a call of the function =E2=80=9Cblkg_lookup_check=E2=80=9D failed,
  release the previously allocated block group before jumping
  to the target =E2=80=9Cfail_unlock=E2=80=9D in the implementation of
  the function =E2=80=9Cblkg_conf_prep=E2=80=9D.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
