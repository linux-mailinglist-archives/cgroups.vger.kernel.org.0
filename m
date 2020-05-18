Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6975F1D7AAC
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 16:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEROHO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 10:07:14 -0400
Received: from mout.web.de ([212.227.15.4]:40907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgEROHO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 May 2020 10:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589810819;
        bh=bKxwgZuQN7kNtLLFjAQSHsWwwY7I6KjCkB1Igwn9wj0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Fj9vHeB8O8VYoiABiQF3yqDmXHsAgo3nUYhVRdMHEqgQSUIePk0Nqvefl1kI65/L1
         NjapP+KPtI5hSvLOFEgtqU7Rnn2LgGekg9fU3IcMHRzvQz5KUpgwFOLqz8KUnrRUdV
         Nl633NSPfr+FncGDiyu8v9nQcHgjs7a22I1sSqmo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.105.123]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1jfbq10NmQ-00691M; Mon, 18
 May 2020 16:06:59 +0200
Subject: Re: [PATCH v2] blkcg: Fix memory leak in blkg_conf_prep()
To:     Wu Bo <wubo40@huawei.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Feilong Lin <linfeilong@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <1589805366-328489-1-git-send-email-wubo40@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <48c1964b-a939-b33f-2c47-90ac7069317a@web.de>
Date:   Mon, 18 May 2020 16:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589805366-328489-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sI80ThizeS69KMTqvvhc6bRRc3+j+Tg46Ywq9rCnop+dAKb9vYh
 P57NZtMHMxbQ3XW8dFwD3/BEdRIX5ir34/pIF9xtJghA4bnF9rbjh4sZs4mbSDMAMie6mUV
 8uEG39j5DD4YiSimtuq7b8NqW6F2TmcxPKZPHzs0tP4JDpHpNOMxKlcrUDIDjN6NAF+que/
 E3R5Sd7myeKnybs97gYSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQTKaumUWdI=:H8E1bp864IKX9wfAT9++BJ
 6lb1Ur9H5jHn6MvoukUZBeDxW5wcCC7yYCrZz9m78SIeMDLIvDHr/+L0SHKc79MXcnNNH42tn
 O/6ZvlQT8mrt6kQjPcRW723XFDSLHrXyQgHYedUR4nSjxrFlg8kUUDB+Jv03RpDiwvTJqyM/f
 fh3VY2AWhkjrhEucUxiayuA+FBHjD3AVBI4fLr/T3TJ5mQ7XScoEjLfnTrFhH+/m13MRikmYM
 NmQW7fGjzSlCcZRhkZKx77FmxkyZ2F7yH+KUFJENnjzPdTyNWr+vydJIqjRb2DSpGrKujZwU/
 7uAW8ijAIb3LzgknIzpd08Jql08S1XBIeD+MqSivnrhbGjgjI1CAoHgUZ4ysSEn1hzL3YotTL
 K/DYihZuDQQDStPNxc1kceAjpcPh1hhwdDWjXn+02MweHlpYOv74uFwc6vXULA2FqTZB3pixq
 sPXxPHxfsLxWiNPhvf3WjoImtzJy0IL31SQN7y7BfRId3iHFKbCgNOGQpJzZquVSW8IbXd1mm
 pg78cm9YGduGrbgiccMfWgS4HI206u0z6mCwhe8nmBSSGBhKA5k3BXCM4vwmf0O3oUqE1JuQS
 iVkrECqHWS3gpc279AySmnVehzL3arRyCDAXlcjo612cpLAemvZtWaitfSi3DK4DvorXXHvIp
 tJoA4rVBS4vtJAh7FEOUmEqbKiueuHUsU3xUDZke3W9C3aZUkiSdWs8xhIWQc7yRsoiamxJzp
 Ow6ImgHA64atxbBCRwjDAodRIvJ+MfHJi9fDfNlD3vzSV/TFQHrWjocgQY2o2ZSNDaQ7CR3DE
 UGZkxu68UJXv+nXLFUV3Si9gWSg8Q309G6zD1D4uPd9p/Ba6ftq/Wkby/ORfCP+iHejTSkuVV
 4R6wyvLyq+dQa0HHjIsJqMZUSV2QQMX2GMhSmoQC8M7gly8VfnQ1nAp5EWlcTujuAZKvhP6C+
 4d/xBtEdunGNgDj36Rv9PXnGbeANo9bEn/sLtk67WBHRCi/f/lZWU+B+bAuhaVivigbLndxXb
 PnGfDUzbIZpFaHCLCBqYWtlMeIxjVrsoAnS/+z0FCZFmdeXFO/sjilhWMnExFaeSj6jBnNNQ1
 xHvqzNiBgWnaFXHLfmugXDlwJOoUhbkzMizLO9xjnWeB6EkxkBzSpBKWc2EExdySAoAH7wBOb
 sYhbv6hxsrTBao3ps2+5hK3pGhS3ot3vi9ot02odnnYUpsrch45CoT61VDvISqKUjNf+LpX4J
 RuLtfUyDDhjyl9WWQ
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> If a call of the function blkg_lookup_check() failed,

Thanks that you would like to integrate something from my suggestion.


> we should be release the previously allocated block group

I find that an other wording would be preferred over =E2=80=9Cwe should=E2=
=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db9bbe6ed63b2b9f2c9ee5cbd0f=
2c946a2723f4ce#n151


> before jumping to the lable 'fail_unlock' in the implementation of

Please avoid another typo here.


> the function blkg_conf_prep().
>
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>

I find this tag questionable because the bug fix was presented before.
https://lore.kernel.org/linux-block/4c670a6c-98c3-2b14-7438-09199506d92f@w=
eb.de/
https://lkml.org/lkml/2020/5/15/779


> ---
> V2: omit the source code quotation from
>     the change description

* I recommend to improve also the patch subject accordingly.

* Would you like to move the name from the previous tag into
  this information?


> ---
>  block/blk-cgroup.c | 1 +

I suggest to omit the triple dashes before this diffstat.

Regards,
Markus
