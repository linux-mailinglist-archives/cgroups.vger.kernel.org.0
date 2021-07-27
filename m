Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B243D6C50
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 05:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhG0CZ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 22:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbhG0CZ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 22:25:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA9C061757;
        Mon, 26 Jul 2021 20:06:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b6so15769049pji.4;
        Mon, 26 Jul 2021 20:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ChIcbIgLJX/+eQRpKvWif40abxApwvOjyIFA0z+RMsM=;
        b=MU3drwGpgkx0vfwBNTNFP3MytUOGuJQ3j50dvYOId0AswZfumYMStyl+z6WjZn8xss
         wI9eMWl1JEQ+vqomHrTtUT/LVF3rDed6w82f5LQfMDYZSoekPsqtQzVGOYDovAlJE/TC
         VmCmyIum9y/x/IVwYRAdiqmJLu3EsPtXbTxre38qt9Ba5523aYlhBBqBbuqnNS9dl9WU
         0qAJP+FHqHlfzwOWW5nLyuWaDTso5jq165pKxv+ahBbkeq34+qjQdiCu8UtMRhU80vmt
         IsXYvdC6U0ZF0PIu/yOZitNgkmXGyW1foxBDYZ2E01JWlM+Hf4G/MzKs0AKlOj/msRsB
         gpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChIcbIgLJX/+eQRpKvWif40abxApwvOjyIFA0z+RMsM=;
        b=Qghna7UGMn0X971c7g5ZmH6XMNw1e+V6kw9fpz9G3NwbpOx/usIHfdYSokVSMz1K+s
         JWp/VnViXPQUNiqVGGTTsEaW7rkdoC86buFQK1PBuIOlBzj//b5VG9YNCJqmhnqdY7Cs
         MTmMVlR28siLW5dqFiJEEAA948P7W53WL8c5g13P2nkvWdRqrMgMxfvEkHWldL6afgfP
         tPJQEWlHPzm5/LQta2Bc3VD/ZzbwXYmcBHVY0yo9JcvDPzB8fTEyPne30/t5HNf8SsA1
         NoE6CWpFBkbHOzrPCXpAGOaV6ciuVKAJVZRzryVU982x4yI/vxaHFdJiJnYJKRplHI2+
         qdIQ==
X-Gm-Message-State: AOAM5307D3tFIueSZqiPAcPpSO4Ik53tkyBQVpTDmERDckuQE9ANWQrF
        U84obVqBDLXiz+dDAh3ziQhRBhtpY8K+iw==
X-Google-Smtp-Source: ABdhPJwG7wwIxzZ6bDxr27zwilvp6TmOlIGZfFSYIAhf6kFR471Ry7M3LO0iXAqErBPXXMCu8Ra0Kg==
X-Received: by 2002:a63:455e:: with SMTP id u30mr8136269pgk.401.1627355184784;
        Mon, 26 Jul 2021 20:06:24 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id p3sm913781pjt.0.2021.07.26.20.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 20:06:24 -0700 (PDT)
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
 <YPGvIzZUI+QxP1js@mtj.duckdns.org>
 <957ab14d-c4bc-32f0-3f7d-af98832ab955@gmail.com>
 <YP8tPwkJNMAcjDqk@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <34a6f4b5-9055-e519-5693-068f8dcb169c@gmail.com>
Date:   Tue, 27 Jul 2021 11:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YP8tPwkJNMAcjDqk@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Tejun Heo wrote on 2021/7/27 5:46:
> Hello,
> 
> On Tue, Jul 20, 2021 at 12:35:54AM +0800, brookxu wrote:
>> In order to avoid code duplication and IOPS stability problems caused by estimating
>> the equivalent number of IOs, and to avoid potential deadlock problems caused by
>> synchronization through queue_lock. I tried to count the number of splited IOs in
>> the current window through two atomic counters. Add the value of the atomic variable
>> when calculating io_disp[rw], which can also avoid the problem of inaccurate IOPS in
>> large IO scenarios. How do you think of this approach? Thanks for your time.
> 
> I guess it's okay but am still not a big fan of adding another hook. This is
> primarily because blk-throtl is sitting too early in the stack - e.g. rq_qos
> is doing the same thing but sits after the split path - and it's a bit nasty
> to add an additional hook for it.
> 
> Do you think it can be an option to relocate the blk-throtl hooks to the
> same spots as rq-qos or, even better, make it use rq-qos?

Make blk-throttle use rq-qos may be more elegant. But I found that there may be at least
one problem that is difficult to solve. blk-throttle supports separate throttle for read
and write IOs, which means that we cannot suspend tasks during throttle, but rq-qos
throttle IOs by suspending tasks.

We may be able to relocate the blk-throttle hooks to the rq-qos hooks. Since we may not
be able to replace the throttle hook, in this case, if we register a rq-qos to the system,
part of the blk-throttle hooks is in rq-qos and part hooks not, which feels a bit confusing.
In addition, we may need to implement more hooks, such as IO merge hook.

Thanks for you time.

> Thanks.
> 
