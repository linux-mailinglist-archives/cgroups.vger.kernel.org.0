Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9883F46FEAD
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhLJK1T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 05:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhLJK1S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 05:27:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B856BC0617A2
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 02:23:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so28198613edc.6
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 02:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RhcNME8TKvIC091+E24ipgQ5jFFJHEZIioS3/i94A5g=;
        b=kEqCxBLp0pqz7dfAy1XCRSof85ZGCTYONFa/fsiyuXgzpTTPNVCktFtmb8KnJZbgGS
         ZKKlecZz0D9P2mux41wenBzPhLv+o64L3zqNieN7xdWyZEwyaQo1JRkx8p6Snuwc9MJ5
         M1t2m6BKGwRHC58CgBxQlptDEuQ/+W/7VNvKE0lWSnfdvLAFiqUy/mQgWbN491oCTt89
         b/0YzB8vygER+4TFEg8xNftOYJhRcU+LzJ5riekqX0e78UNWQprxxi9gpIEO093rljWZ
         cNtWusFHtgeRhL5BeS+YtzGPMSU1UUcYHV/lJY86zJ8j/gbkje7WBAH967OX2gZ2naTm
         9aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RhcNME8TKvIC091+E24ipgQ5jFFJHEZIioS3/i94A5g=;
        b=TxIL34+90ROWhmXh1G5TC7kdYyLdXN744WAXB6mFZNdIrtpCvKAbFMszMeWIZmj0Cj
         VhexpZ1LT7ZxTO4rMff6wiomr8iZ3g3P6TBK6/dWncV1FtgCO2MjI0ybT8F4wiJ8Pg9c
         D3UZfu6yt7NT5YTSmC4zE1T5D8QRcsE+vHSgMs69NsHdXKgqYB263BSplQVrTO2ShK0n
         7oYGMEZGZLxV6V9uap/EbqdAFL6iibMr79ghIgYJzvWUuckMJvkDiLURxhXxPXkeXlkL
         lAqoDSePojOOJquc+dGcwG2T1qHlzBH8/1kfrDgnE6KUlheaJjR+PAHof5WqFQuGCSnB
         3QjQ==
X-Gm-Message-State: AOAM5306amgvMgKC/odzqdpS4mjhL0ML8gJt9aKjO5bYx5fSsxlXZSli
        xE22ITkNKyMn2D4saXzkZx1LZw==
X-Google-Smtp-Source: ABdhPJxNfvUrlfghsa7j6MH2qZEdLiTNPzA5t1H66pFeQgizIuDaKpX047Lu4EglWFUBwgyiWAYX9Q==
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr36702766edf.400.1639131821500;
        Fri, 10 Dec 2021 02:23:41 -0800 (PST)
Received: from [192.168.1.8] (net-93-70-85-65.cust.vodafonedsl.it. [93.70.85.65])
        by smtp.gmail.com with ESMTPSA id j4sm1194278edk.64.2021.12.10.02.23.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:23:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 0/9] support concurrent sync io for bfq on a specail
 occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <809b90cc-20ba-c4fd-8c29-b9e3123c1cef@huawei.com>
Date:   Fri, 10 Dec 2021 11:23:39 +0100
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9F1D3F7-2C76-4301-944B-0BD1A2A5FE83@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <D3FF0820-6A51-46A1-A363-8FFA8CCD2851@linaro.org>
 <809b90cc-20ba-c4fd-8c29-b9e3123c1cef@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 10 dic 2021, alle ore 10:50, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> =E5=9C=A8 2021/12/10 17:20, Paolo Valente =E5=86=99=E9=81=93:
>>> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>=20
>>> Bfq can't handle sync io concurrently as long as the io are not =
issued
>>> from root group currently.
>>>=20
>>> Previous patch set:
>>> =
https://lore.kernel.org/lkml/20211014014556.3597008-2-yukuai3@huawei.com/t=
/
>>>=20
>>> During implemting the method mentioned by the above patch set, I =
found
>>> more problems that will block implemting concurrent sync io. The
>>> modifications of this patch set are as follows:
>>>=20
>>> 1) count root group into 'num_groups_with_pending_reqs';
>>> 2) don't idle if 'num_groups_with_pending_reqs' is 1;
>>> 3) If the group doesn't have pending requests while it's child =
groups
>>> have pending requests, don't count the group.
>> Why don't yo count the parent group? It seems to me that we should =
count it.
> Hi, Paolo
>=20
> For example, we only issue io in child group c2(root->c1->c2),
> 'num_groups_with_pending_reqs' will end up greater than 1, thus it's
> impossible to handle sync io concurrently. Thus I don't count root and
> c1, only count c2.

Right!

Please explain this clearly in comments.


>>> 4) Once the group doesn't have pending requests, decrease
>>> 'num_groups_with_pending_reqs' immediately. Don't delay to when all
>>> it's child groups don't have pending requests.
>>>=20
>> I guess this action is related to 3).
> Yes, if c1, c2 are both active, and then c1 don't have any pending =
reqs,
> I want to decrease num_groups_with_pending_reqs to 1 immediately.

I'll check this point directly on the patch that does this decrement,
because something is not clear to me.

Thanks,
Paolo

>  So
> that sync io on c2 can be handled concurrently.
>=20


> Thanks,
> Kuai
>=20
>> Thanks,
>> Paolo
>>> Noted that I just tested basic functionality of this patchset, and I
>>> think it's better to see if anyone have suggestions or better
>>> solutions.
>>>=20
>>> Yu Kuai (9):
>>>  block, bfq: add new apis to iterate bfq entities
>>>  block, bfq: apply news apis where root group is not expected
>>>  block, bfq: handle the case when for_each_entity() access root =
group
>>>  block, bfq: count root group into 'num_groups_with_pending_reqs'
>>>  block, bfq: do not idle if only one cgroup is activated
>>>  block, bfq: only count group that the bfq_queue belongs to
>>>  block, bfq: record how many queues have pending requests in =
bfq_group
>>>  block, bfq: move forward __bfq_weights_tree_remove()
>>>  block, bfq: decrease 'num_groups_with_pending_reqs' earlier
>>>=20
>>> block/bfq-cgroup.c  |  3 +-
>>> block/bfq-iosched.c | 92 =
+++++++++++++++++++++++----------------------
>>> block/bfq-iosched.h | 41 +++++++++++++-------
>>> block/bfq-wf2q.c    | 44 +++++++++++++++-------
>>> 4 files changed, 106 insertions(+), 74 deletions(-)
>>>=20
>>> --=20
>>> 2.31.1
>>>=20
>> .

