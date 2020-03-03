Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75021777BA
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCCNs6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 08:48:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34314 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCNs6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 08:48:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so3436895qkd.1;
        Tue, 03 Mar 2020 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eeNzn8H18FzPdQesLxTltwdmSd8JJDcXIg9kUyzHqWE=;
        b=WUhEHc5vql7ujIsEF3YHXKRSPLmhv/fLYpNQcZJljQqi4gtjdwhw6AbZIFvY082EsT
         LrzFJH1uw3wD4vcFMkziFsHeadM0WGFkWAPGsvoHm1sEwZKWYU3jvijiuYlmS3FbEl4W
         ATccS1Mzp8UkXzZkfb+SMX8fJnqeOUKNbFudgw329WdafEFjgsmDO2FD1P098aeK+ji5
         WK9shX1psrjhZS0EvBjaqf/AoNNd/A033bf4uZh+I6Br1UBnip1h0bBG/Ow9RG7V8BOm
         mHQe0xu2/SZnPvFdU/16fTcMa1lqkxZeGdhawwAOQOSEgGOYqdCTXIaSGZfX2Kfsw9qs
         3BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eeNzn8H18FzPdQesLxTltwdmSd8JJDcXIg9kUyzHqWE=;
        b=kUT3WBau0N+T4qPDx6qqH1Kh0cS0El8jW8BiqKl9iIUmrIah1kbFDCTKWRKm4agmjR
         e0p6RtOZyuTpFkI42aicvZbzwQDoiL4lFACs2dlYpmRG77GKP5H9DoGoGLmagcw38RGZ
         WVHNtAQGLg9R2QR2KAxg/Td/wl9LzyXfbUzJShvgUmus5Q4AMaFgy8soYkwCqaxfy0Da
         JTQsGEEhHL6nGLg3cSOJ0RDBMtzGYoSHEhd/KLz/ddmh8IPobp0Ydk+4JyQVg75X6Elk
         fJ+1jmLAwyTvM9y2Tsld1bV7BnTvRSa7lR1l9drZxz9PKrhd3xbTq9h+VxuTuefs7rTU
         S/Aw==
X-Gm-Message-State: ANhLgQ1KKp5MbzJ8Ilq7hZkWgtk2wYVJfT5t5Uf5FvS1J0RQYoA6eU0F
        1MmqCW5WC3ODmU46N+9hL58=
X-Google-Smtp-Source: ADFU+vv+/21QpMv7FaTPOu9N6rpSb7Pfkdm41cSmaitTrxEEzsg2WiPzIAFx1GdV88BpbsT9EbLvQw==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr4315267qks.235.1583243337163;
        Tue, 03 Mar 2020 05:48:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id e7sm3321488qtp.0.2020.03.03.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:48:56 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:48:55 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Marco Ballesio <balejs@google.com>
Cc:     guro@fb.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        minchan@google.com, surenb@google.com, dancol@google.com
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200303134855.GA186184@mtj.thefacebook.com>
References: <20200219183231.50985-1-balejs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219183231.50985-1-balejs@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Feb 19, 2020 at 10:32:31AM -0800, Marco Ballesio wrote:
> @@ -94,6 +94,18 @@ The following cgroupfs files are created by cgroup freezer.
>    Shows the parent-state.  0 if none of the cgroup's ancestors is
>    frozen; otherwise, 1.
>  
> +* freezer.killable: Read-write
> +
> +  When read, returns the killable state of a cgroup - "1" if frozen
> +  tasks will respond to fatal signals, or "0" if they won't.
> +
> +  When written, this property sets the killable state of the cgroup.
> +  A value equal to "1" will switch the state of all frozen tasks in
> +  the cgroup to TASK_INTERRUPTIBLE (similarly to cgroup v2) and will
> +  make them react to fatal signals. A value of "0" will switch the
> +  state of frozen tasks to TASK_UNINTERRUPTIBLE and they won't respond
> +  to signals unless thawed or unfrozen.

As Roman said, I'm not too sure about adding a new cgroup1 freezer
interface at this point. If we do this, *maybe* a mount option would
be more minimal?

> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index dc520f01f99d..92de1bfe62cf 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -42,6 +42,9 @@ bool freezing_slow_path(struct task_struct *p)
>  	if (test_tsk_thread_flag(p, TIF_MEMDIE))
>  		return false;
>  
> +	if (cgroup_freezer_killable(p) && fatal_signal_pending(p))
> +		return false;
> +
>  	if (pm_nosig_freezing || cgroup_freezing(p))
>  		return true;
>  
> @@ -63,7 +66,12 @@ bool __refrigerator(bool check_kthr_stop)
>  	pr_debug("%s entered refrigerator\n", current->comm);
>  
>  	for (;;) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		bool killable = cgroup_freezer_killable(current);
> +
> +		if (killable)
> +			set_current_state(TASK_INTERRUPTIBLE);
> +		else
> +			set_current_state(TASK_UNINTERRUPTIBLE);
>  
>  		spin_lock_irq(&freezer_lock);
>  		current->flags |= PF_FROZEN;
> @@ -75,6 +83,16 @@ bool __refrigerator(bool check_kthr_stop)
>  		if (!(current->flags & PF_FROZEN))
>  			break;
>  		was_frozen = true;
> +
> +		/*
> +		 * Now we're sure that there is no pending fatal signal.
> +		 * Clear TIF_SIGPENDING to not get out of schedule()
> +		 * immediately (if there is a non-fatal signal pending), and
> +		 * put the task into sleep.
> +		 */

and this looks really racy to me. What happens if this task gets a
fatal signal here? We clear TIF_SIGPENDING and go to sleep?

> +		if (killable)
> +			clear_thread_flag(TIF_SIGPENDING);
> +
>  		schedule();
>  	}

Thanks.

-- 
tejun
