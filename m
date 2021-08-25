Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCDC3F7CA1
	for <lists+cgroups@lfdr.de>; Wed, 25 Aug 2021 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbhHYTT7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Aug 2021 15:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241714AbhHYTT4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Aug 2021 15:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629919141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlFG0K25NAvNlMR4L6awyzjcPNxdeBB4rbGkjSKsifw=;
        b=IkvOdI95zMA25H8Y7fmPBMDDle1GIb2KbtvwZN75HyMqLhXg+Aa6LgnivteqGSGq6x2Ioz
        wI7apgFGLOe8vkIaDdnu2tK5o6Sy+XFsTauJvUe7hNo0Cbms2ll453Zd/3YcCZz0VooP95
        z4gVTVX+wst3BEG/mKPAxzBhQn2wGDE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-qsJlThLmOeyLFJPiVEuv2A-1; Wed, 25 Aug 2021 15:19:00 -0400
X-MC-Unique: qsJlThLmOeyLFJPiVEuv2A-1
Received: by mail-qv1-f70.google.com with SMTP id n14-20020a0c9d4e0000b0290354a5f8c800so533944qvf.17
        for <cgroups@vger.kernel.org>; Wed, 25 Aug 2021 12:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SlFG0K25NAvNlMR4L6awyzjcPNxdeBB4rbGkjSKsifw=;
        b=GuiDWssLuZheR1nsO86Ya5gg7rZbRi6Zq3/3PGBJJWf//avzdxx/Ytbfa41/ZRODY5
         hCu8CKRhcP6Xw8y1H92GKVOJYWrlNnmDlaI5hUOR3rpZa3/mAx306oold2spgP/TeHU/
         XBpnehZOWjvsvXWA5jZ5vdaN0usTkxKpG38KkRLoz9VfU1emxwfILvBRywGz3p8Obds0
         I6Tqg9BhjgWmBLrTGeGJUsE5+oKmpRCBJKzE+5zmvDFQ3UO+Srq98sXgRi4bBs5XrVJ2
         uyPovR7oWA0qEdUNgDL6XJ1ZhvOnestVGtVqzIksPitWCZuShNQa3Hixjp5gTX2O3YWl
         sHKg==
X-Gm-Message-State: AOAM531Z9C1ju3tfDgoxsa8GdjflcT0746HNO2NOLCVZNC03bhGkdJqd
        BrFgn8bvm3TfXKzgNUqZwra+D+VxeQVkNBNnVWbYqISLgC6BtBXe1Aswuc/6Va0ovsQcoNLM9am
        XydwfPU1WQu0uUpKiyQ==
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr104699qkp.388.1629919139778;
        Wed, 25 Aug 2021 12:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ6MGY9izwKhvnW1NUtm1KDyHJWPNCxdpt3UMt2ufIM7rxm3F+w63cvbPKjEULjmcSgkV0pw==
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr104676qkp.388.1629919139514;
        Wed, 25 Aug 2021 12:18:59 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id y15sm608683qko.78.2021.08.25.12.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 12:18:58 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Avoid memory migration when nodemasks
 match
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mtosatti@redhat.com, nilal@redhat.com, frederic@kernel.org
References: <20210825105415.1365360-1-nsaenzju@redhat.com>
Message-ID: <b404f50a-6a35-92d5-1500-613296d0807f@redhat.com>
Date:   Wed, 25 Aug 2021 15:18:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825105415.1365360-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/25/21 6:54 AM, Nicolas Saenz Julienne wrote:
> With the introduction of ee9707e8593d ("cgroup/cpuset: Enable memory
> migration for cpuset v2") attaching a process to a different cgroup will
> trigger a memory migration regardless of whether it's really needed.
> Memory migration is an expensive operation, so bypass it if the
> nodemasks passed to cpuset_migrate_mm() are equal.
>
> Note that we're not only avoiding the migration work itself, but also a
> call to lru_cache_disable(), which triggers and flushes an LRU drain
> work on every online CPU.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
>
> ---
>
> NOTE: This also alleviates hangs I stumbled upon while testing
> linux-next on systems with nohz_full CPUs (running latency sensitive
> loads). ee9707e8593d's newly imposed memory migration never finishes, as
> the LRU drain is never scheduled on isolated CPUs.
>
> I tried to follow the user-space call trace, it's something like this:
>
>    Create new tmux pane, which triggers hostname operation, hangs...
>      -> systemd (pid 1) creates new hostnamed process (using clone())
>        -> hostnamed process attaches itself to:
>    	 "system.slice/systemd-hostnamed.service/cgroup.procs"
>          -> hangs... Waiting for LRU drain to finish on nohz_full CPUs.
>
> As far as CPU isolation is concerned, this calls for better
> understanding of the underlying issues. For example, should LRU be made
> CPU isolation aware or should we deal with it at cgroup/cpuset level? In
> the meantime, I figured this small optimization is worthwhile on its
> own.
>
>   kernel/cgroup/cpuset.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 44d234b0df5e..d497a65c4f04 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1634,6 +1634,11 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
>   {
>   	struct cpuset_migrate_mm_work *mwork;
>   
> +	if (nodes_equal(*from, *to)) {
> +		mmput(mm);
> +		return;
> +	}
> +
>   	mwork = kzalloc(sizeof(*mwork), GFP_KERNEL);
>   	if (mwork) {
>   		mwork->mm = mm;

Thanks for the fix. So cpuset v1 with memory_migrate flag set will have 
the same problem then.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

