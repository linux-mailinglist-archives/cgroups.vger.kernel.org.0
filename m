Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35827477934
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 17:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhLPQeL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Dec 2021 11:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbhLPQeK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Dec 2021 11:34:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57793C061574
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 08:34:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z29so8885000edl.7
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YIxQQ6KDBZhBgpCjwTDT7xZgLL24q7Pq/WYlBcp43Wc=;
        b=P4zJ4MdxI3Nrq2mTejPtTAUCz2UTy2xuQFXkgZ51A3KEZY3c8BbN2FMPLzvgbMKG/q
         2CS3yZFEyqHxMzPI6X1GpdoEf7/MOX2c3YmQETBCmfW78pISipn2xqcOZbdiJgvCNJiw
         3VJ2atCKDqhYMLBfQPRzc95ji4OpWuWcZG6iYnojd5q6N19g6zvgS20ZcXYBq+xz3uM+
         Ror14fJKf1hGgsQL8KDApaQr3lj8beuTP3xEei2gF56D1gL6W7lmSjr0NrbQP3GXVzpm
         FAY4tBJcjTbSjdm3thtN8R96q5Qt/7rsyyynLkRfFW7fF8ZlcPnfDkvN3Y1lE37hmhOW
         Zkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YIxQQ6KDBZhBgpCjwTDT7xZgLL24q7Pq/WYlBcp43Wc=;
        b=WE/0uT8AaiNyqWBmymMtWZqStY9WiCYxHqXEDGOsXsq7UPf1w0mB6nl8EdelQPaqjV
         x1oPZ7FHlAgPKbVx1hJP/eNyF4848R/8jPrqGN2rC08APVSj1URy7FxedmG2cPm/hAaV
         /DxL37drlXJlcOhelXMgwQiKMYWgFFc1hmGSTwlDydg02ybFf0hzwURfBflsJsaBR4W8
         A63A//A7XS3SQF447yTbWc9zunvYIFlwm6oktVY8di2wxwol+EDCp5S2wO6QBPPOEz4C
         IHJDBISvTCKD/YaH50uA7wBL53KPX+v0EbKaytzq2aJq7S7P9BS+TCsPUTo+W6cELmhO
         YppA==
X-Gm-Message-State: AOAM533jlsZ0GFhY8RLf93r31QfoezYJqFfRufWpRuWhMlM/oDdkz5lK
        jASam5sMnwC68a1jXkJ8Sy4Fag==
X-Google-Smtp-Source: ABdhPJzF8h8sUsqhmrPvbnHY0/fmYX/iET/VxwEtCPRcQ1Dc0xW/7REFzhZEkkq+0vwLjwhjjvUEIA==
X-Received: by 2002:a17:906:c7c9:: with SMTP id dc9mr6960432ejb.559.1639672448083;
        Thu, 16 Dec 2021 08:34:08 -0800 (PST)
Received: from [192.168.1.5] (net-93-70-85-238.cust.vodafonedsl.it. [93.70.85.238])
        by smtp.gmail.com with ESMTPSA id 8sm1956208ejb.9.2021.12.16.08.34.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:34:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 9/9] block, bfq: decrease
 'num_groups_with_pending_reqs' earlier
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4765e7f8-48b7-3bc6-5eb6-1dc0a569233d@huawei.com>
Date:   Thu, 16 Dec 2021 17:34:06 +0100
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5C2B1F6-4DF9-4657-AFF4-D53DD04A65DC@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <20211127101132.486806-10-yukuai3@huawei.com>
 <AA66019E-FD14-4821-B53D-0C56EEC38828@linaro.org>
 <4765e7f8-48b7-3bc6-5eb6-1dc0a569233d@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 11 dic 2021, alle ore 03:10, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> =E5=9C=A8 2021/12/10 18:21, Paolo Valente =E5=86=99=E9=81=93:
>>> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai<yukuai3@huawei.com>  =
ha scritto:
>>>=20
>>> Currently 'num_groups_with_pending_reqs' won't be decreased when
>>> the group doesn't have any pending requests, while any child group
>>> have any pending requests. The decrement is delayed to when all the
>>> child groups doesn't have any pending requests.
>>>=20
>>> For example:
>>> 1) t1 issue sync io on root group, t2 and t3 issue sync io on the =
same
>>> child group. num_groups_with_pending_reqs is 2 now.
>>> 2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 =
and
>>> t3 still can't be handled concurrently.
>>>=20
>>> Fix the problem by decreasing 'num_groups_with_pending_reqs'
>>> immediately upon the deactivation of last entity of the group.
>>>=20
>> I don't understand this patch clearly.
>> I understand your proposal not to count a group as with pending =
requests, in case no child process of the group has IO, but only its =
child groups have pending requests.
>> So, entities here are only queues for this patch?
>> If they are only queues, I think it is still incorrect to remove the =
group from the count of groups with pending IO when all its child queues =
are deactivated, because there may still be unfinished IO for those =
queues.
>=20
> Hi, Paolo
>=20
> bfq_weights_tree_remove() will be called when all requests are =
completed
> in bfq_queue, thus I recored how many queues have pending requests
> through weights tree insertion and removal.(Details in patch 7)
>=20
> Thus when calling bfq_weights_tree_remove() for bfqq, I can check if
> there are no queues have pending requests for parent bfqg:
>=20
> if (!bfqg->num_entities_with_pending_reqs && -> no queues with pending =
reqs
>    entity->in_groups_with_pending_reqs) {   -> the group is counted
>=20

Ok, I got confused because you use the term deactivation.  Yet you
seem to decrement the counter at the right time.  Maybe fix that term,
in commit messages and comments.

Thanks,
Paolo

> Thanks,
> Kuai
>> Am I missing something?
>> Thanks,
>> Paolo

