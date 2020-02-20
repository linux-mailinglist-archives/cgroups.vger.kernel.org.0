Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33B016654D
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgBTRuF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 12:50:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36554 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgBTRuF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 12:50:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so3491107qto.3
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9LcvSEumTmXyuKFplLOO57e96BKQQeEk4RY39TL+hio=;
        b=VHirKNJDDO682guKBEd7Lh4Sdhh51LWyOruN25/r3aHd6uttqamXF0Y2SA7SURFcGF
         9L68VvTMCycQxV8a8PVSRKwVlrRBX6dROpPZI2+TYVXxntJtO4mJrARFdxtJn8K2f0LX
         7jmviilTZKEOD7cXwUqgwwYTXTAlVCWI4H8HphGY1AyOS0JkzhcsRMoHBwScPbu+Eghl
         lr3mqrpjO/hI6Mqqpdz1bwAZpagS8xbsNMtYg/gVu4+EkG2nZ7e+seyK7JK9UOIIsSbW
         iktcaKz88wwRW8q1+2Iz7hLBH+IFUEheTfhVWoJQBx196zKDvstwAtnve1heQWmWVFey
         OZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9LcvSEumTmXyuKFplLOO57e96BKQQeEk4RY39TL+hio=;
        b=LTSmcgkzeMSACPYC/RTcpO/OXxuAD47iNg1l5ZQ6lw97lkQAaduKYUaQslL6ODfdCz
         +cu/RriSMfP01+hegVPrvCQRwkRaTeB/CNhD4ipGBx5UBhTGEbBjBsHy08RGJAendBZ1
         GKHlxIA4rR2a5Ij5AYWv2JzBsbgkoj8pKtrFKTiAFP2mcRCX72vYtaE2Fs+7aBefioaB
         LOp3x5iOnuYldtzdU8pVGK2ruBZEfoodPfNDS+gqQWoYRXCdKWOWVRYP20j6KygVxBJg
         2Bncz/04rujytk2iQB9i7L54mqT8R9WWLDoYca8q2s6ckXDlV10q4NX2ODaEwUkbpvt2
         AT9g==
X-Gm-Message-State: APjAAAW22TYM8jqwBdSyeWlwIABlbNc/PRNuC4bneXJTVUSjNOJYlc4U
        aB5eM7I431mLXhKFmgBjV70rIw==
X-Google-Smtp-Source: APXvYqzbtO/RIeVYLc6mfivNPQO8ldS0h+Q0UAxefaixOy8FmrW7r/AiWxWUfsQFv7WDc0SriYliDw==
X-Received: by 2002:ac8:1ac1:: with SMTP id h1mr27444991qtk.255.1582221004432;
        Thu, 20 Feb 2020 09:50:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:3504])
        by smtp.gmail.com with ESMTPSA id 65sm123024qtc.4.2020.02.20.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:50:03 -0800 (PST)
Date:   Thu, 20 Feb 2020 12:50:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/3] loop: Use worker per cgroup instead of kworker
Message-ID: <20200220175002.GJ54486@cmpxchg.org>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <118a1bd99d12f1980c7fc01ab732b40ffd8f0537.1582216294.git.schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118a1bd99d12f1980c7fc01ab732b40ffd8f0537.1582216294.git.schatzberg.dan@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Dan,

On Thu, Feb 20, 2020 at 11:51:51AM -0500, Dan Schatzberg wrote:
> +static void loop_process_work(struct loop_worker *worker,
> +			struct list_head *cmd_list, struct loop_device *lo)
> +{
> +	int orig_flags = current->flags;
> +	struct loop_cmd *cmd;
> +
> +	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
> +	while (1) {
> +		spin_lock_irq(&lo->lo_lock);
> +		if (list_empty(cmd_list))
> +			break;
> +
> +		cmd = container_of(
> +			cmd_list->next, struct loop_cmd, list_entry);
> +		list_del(cmd_list->next);
> +		spin_unlock_irq(&lo->lo_lock);
> +		loop_handle_cmd(cmd);
> +		cond_resched();
> +	}

The loop structure tripped me up, because it's not immediately obvious
that the lock will be held coming out. How about the following to make
the lock section stand out visually?

	spin_lock_irq(&lo->lo_lock);
	while (!list_empty(cmd_list)) {
		cmd = container_of(cmd_list->next, struct loop_cmd, list_entry);
		list_del(&cmd->list_entry);
		spin_unlock_irq(&lo->lo_lock);		

		loop_handle_cmd(cmd);
		cond_resched();

		spin_lock_irq(&lo->lo_lock);
	}

> -	loop_handle_cmd(cmd);
> +	/*
> +	 * We only add to the idle list if there are no pending cmds
> +	 * *and* the worker will not run again which ensures that it
> +	 * is safe to free any worker on the idle list
> +	 */
> +	if (worker && !work_pending(&worker->work)) {
> +		worker->last_ran_at = jiffies;
> +		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
> +		loop_set_timer(lo);
> +	}
> +	spin_unlock_irq(&lo->lo_lock);
> +	current->flags = orig_flags;
