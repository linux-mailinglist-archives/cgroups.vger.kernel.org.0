Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3157B166A1E
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 23:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgBTWAM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 17:00:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45476 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgBTWAM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 17:00:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so4053263qte.12
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4DEb+MFtlfOkYpWfs64nM33/4kdQBlL8UrNBhh3ectk=;
        b=Kmj9oigm0jMnd4HOhL2kj5adwwG8XTmckWqG+btnWkfj+uDXxwZkdqrxOQ7PGHF76d
         UQIhwBsksdU7D+Tr0CtIQnWeoDw2S0FzAeaOZkKFaGQjh+4tG+7lcFKp1TJdyxwnWBvz
         0xMlnq2i02KkLLLUS3e6GXooE84fiTc0bIa0MWZiFa5PTTiLv4F1ka6+J2bubbPVkwSF
         irbntREuc6iemK8X0WglElHqFXvXyME57ic83jBhi08/Z35rZMunYsQcPNE+C4gQG3TA
         oGV2OVyd97f+UK61/rT8CudV1HpMf+Y52tCRrkdnvwvKDGVKpsp7LtK+f5lf8R+fTbSD
         4wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4DEb+MFtlfOkYpWfs64nM33/4kdQBlL8UrNBhh3ectk=;
        b=NW3KEj2sBGrAgJvaFTWWfXJ17WWynJUZo7N34GlEoBj3sRbDGdU6nZBpY7853Qo9Kl
         0Ow0PmMHW6q72QuzgjF8Y5p0mkYGBeQf6RUiobvGEqG31O+dDEOzAjBlI9lC37RiT46w
         KwArOYOi1Ux9dqZvd+vN4bcw9O1Ks41xTM8wgrW+G/UMKPBNx8oMTpo2sfQbyDyFQoUe
         TRLMikTbhN5kM6awGa6ygJGOPO5hOQgxT434P0jr1tJRQB0f1FR5fRjD6q+UtXT8lLft
         a9A6sC3P8akqlrCJXC6OKc+L/5kNbvUEJs1JYHhHZHpUvoLn8RJwQMnZWc8DQE/kyry7
         QwrA==
X-Gm-Message-State: APjAAAVbVzJTAFgELzFVDFDsQpPEX2cjCfgGHtM3LkBZyXoFCYthenmI
        l3lz85jSOZJZKvlqEuI7+Z+Q7A==
X-Google-Smtp-Source: APXvYqzZ2IaTG8X1flSdo3+y5ECROeJuXsj6tBQM78xzv56U3N32QFxc89XdU6QS/J+WLZO9RtAtKw==
X-Received: by 2002:ac8:72d6:: with SMTP id o22mr28347095qtp.174.1582236011362;
        Thu, 20 Feb 2020 14:00:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:3504])
        by smtp.gmail.com with ESMTPSA id t3sm513004qtc.8.2020.02.20.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:00:10 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:00:09 -0500
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
Message-ID: <20200220220009.GA68937@cmpxchg.org>
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

On Thu, Feb 20, 2020 at 11:51:51AM -0500, Dan Schatzberg wrote:
> Existing uses of loop device may have multiple cgroups reading/writing
> to the same device. Simply charging resources for I/O to the backing
> file could result in priority inversion where one cgroup gets
> synchronously blocked, holding up all other I/O to the loop device.
> 
> In order to avoid this priority inversion, we use a single workqueue
> where each work item is a "struct loop_worker" which contains a queue of
> struct loop_cmds to issue. The loop device maintains a tree mapping blk
> css_id -> loop_worker. This allows each cgroup to independently make
> forward progress issuing I/O to the backing file.
> 
> There is also a single queue for I/O associated with the rootcg which
> can be used in cases of extreme memory shortage where we cannot allocate
> a loop_worker.
> 
> The locking for the tree and queues is fairly heavy handed - we acquire
> the per-loop-device spinlock any time either is accessed. The existing
> implementation serializes all I/O through a single thread anyways, so I
> don't believe this is any worse.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

FWIW, this looks good to me, please feel free to include:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I have only some minor style nitpicks (along with the other email I
sent earlier on this patch), that would be nice to get fixed:

> +static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> +{
> +	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
> +	struct loop_worker *cur_worker, *worker = NULL;
> +	struct work_struct *work;
> +	struct list_head *cmd_list;
> +
> +	spin_lock_irq(&lo->lo_lock);
> +
> +	if (!cmd->css)
> +		goto queue_work;
> +
> +	node = &(lo->worker_tree.rb_node);

-> and . are > &, the parentheses aren't necessary.

> +	while (*node) {
> +		parent = *node;
> +		cur_worker = container_of(*node, struct loop_worker, rb_node);
> +		if ((long)cur_worker->css == (long)cmd->css) {

The casts aren't necessary, but they made me doubt myself and look up
the types. I wouldn't add them just to be symmetrical with the other
arm of the branch.

> +			worker = cur_worker;
> +			break;
> +		} else if ((long)cur_worker->css < (long)cmd->css) {
> +			node = &((*node)->rb_left);
> +		} else {
> +			node = &((*node)->rb_right);

The outer parentheses aren't necessary.

> +		}
> +	}
> +	if (worker)
> +		goto queue_work;
> +
> +	worker = kzalloc(sizeof(struct loop_worker), 
> +			GFP_NOWAIT | __GFP_NOWARN);

This fits on an 80 character line.
