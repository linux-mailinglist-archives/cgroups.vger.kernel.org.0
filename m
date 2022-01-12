Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B648C621
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiALOhO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 09:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241905AbiALOhN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 09:37:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A53C061748
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 06:37:12 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id jr5so3055978qvb.11
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 06:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gN6nYxQ+pi+EX1rhDvVBrSftakRyc+dgBWa+b+GYGOw=;
        b=mUYM4mY5CMZFdZf8LoZxSmr2HrBtGWy/OuRuqq61O/YzMtji9cyv80GCzVs3+/yBQM
         ea8h1TgnQuxezzPUpv+dYIPkHwYXJi8s8RLc3/qoVBJIdyMcJhSjmxQmUkiMYq3Ma/mk
         FCYSRjNlYgSsNDINKB5/QzVJm37I8VUcYMKVK1npArHn3Q6M8h3+azxH7i00hNJ3x5GH
         /MOIqnam32dgIasH341bE3XTjvVfDKCVLNSfwExXT1QlmErmH+Ao3P6BgqP5XnvYn4WD
         4jkB6eQQ2fqopSlJvC4a/kF34giBDtsHPoVyc1PJ8OLUBC1+AAZopBx4/zXrVog6uTYo
         wZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gN6nYxQ+pi+EX1rhDvVBrSftakRyc+dgBWa+b+GYGOw=;
        b=2ci2uYwbAw8bIJMtV059NMH1lkyU3KIFuDA133Ex2y77xGLMlZS4c03+izCeFDvDwp
         WbkOEtfkEeZWJ+N7ve8KhIMbTA5jLo7cFAHQ69JPWEocEr62rZ3Ueaf/5A9UhzYudUh/
         gF4pX68f7kjq6oUyr2+BoTM7J0zS2yay7mKukMejjyVijdyMJ59paXg25h/QkRx72YQm
         q5tl6084CRgXOWBGBFfdU0TLOOD9MDwwNWh73/3HSf+bDOQytO3kEnh268FP9gP2Tcej
         x5t1D9+8uaKEqhou61LhRDx2rU5Ch0FFjcmNCBIhzqWf5qp01EDF+xrMZaedTugMsZAw
         7lQQ==
X-Gm-Message-State: AOAM532b2118hnMe73vsW8fS+baY8clhWum2w+XuVRGd6ZJS22dAz3hf
        sMLESyKY0oYJgwK/KIOw0Y8hTA==
X-Google-Smtp-Source: ABdhPJxY1HshUCe33M5fQkNV7QxIC9vh6OAlDMc4ZVnOi5TLVs7F8THYxcCWfsxToe3z3GOWAGLkKg==
X-Received: by 2002:a05:6214:300a:: with SMTP id ke10mr8262318qvb.98.1641998232082;
        Wed, 12 Jan 2022 06:37:12 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c17sm8211262qkl.90.2022.01.12.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 06:37:11 -0800 (PST)
Date:   Wed, 12 Jan 2022 09:37:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     torvalds@linux-foundation.org, ebiggers@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com,
        syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
Message-ID: <Yd7nlpb5C1asdT9p@cmpxchg.org>
References: <20220111071212.1210124-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111071212.1210124-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 10, 2022 at 11:12:12PM -0800, Suren Baghdasaryan wrote:
> With write operation on psi files replacing old trigger with a new one,
> the lifetime of its waitqueue is totally arbitrary. Overwriting an
> existing trigger causes its waitqueue to be freed and pending poll()
> will stumble on trigger->event_wait which was destroyed.
> Fix this by disallowing to redefine an existing psi trigger. If a write
> operation is used on a file descriptor with an already existing psi
> trigger, the operation will fail with EBUSY error.
> Also bypass a check for psi_disabled in the psi_trigger_destroy as the
> flag can be flipped after the trigger is created, leading to a memory
> leak.
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> Analyzed-by: Eric Biggers <ebiggers@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

That looks good to me, thanks Suren.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Peter, would you mind picking this up and routing this to Linus
through the sched tree, please?
