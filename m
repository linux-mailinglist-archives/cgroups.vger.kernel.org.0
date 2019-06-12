Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63A42E43
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2019 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfFLSCk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jun 2019 14:02:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37729 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfFLSCk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jun 2019 14:02:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so9289535pfa.4;
        Wed, 12 Jun 2019 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+frD1W0PaRHYVfg7bRlg/bAjJXsZpY3XnMe0SfDiS8=;
        b=DPUHU1je3wTkpwlmd4MDNQvT6dUdwrfcgO9977+0I6QZnpSQ06GQLLwWKQDu8JQL4e
         A0s6M+ym0+M2+9lOyg+uLIrUhDvUczKtO7PPnpDIuDx6v1EjhQlNbLMifAD7wHFAjOEz
         SFXRSfsnlETmOJAxvMO7pxUVw8jsxiGVvps9/8pjqDShlbA7FHSvsdbq7m76wH5eV/O4
         6ANvVXTPseOZh3bv4kS9RMlv6PAddZOy135SEKfAITFTRQUBhrZeexigSL9EMMPI5KAW
         i5rZwS18NdwBeTZkhL+ZXrYsTmp6PkS4RxsEhYKDrRm6mC5ZD2TGpxTUnjDwgDytUWJM
         9LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+frD1W0PaRHYVfg7bRlg/bAjJXsZpY3XnMe0SfDiS8=;
        b=r3HySzIMTlMRq7SYaenjrcl4baVOZSzLa4nqvWLn3P+NEgLXHE0shFnzzL1va6XPso
         MRwGWRD5Jga5nkvlzsxq9XI0z3buMH9rEUMbFQPN+1O55S3oJJ710hiS9mGLbldHVIcW
         MM9GwwMEDe1iTjpRGC+0FGCj/+oiEBO2uX85g+QMcn3Ww8kcLB8SjquTESex1aX3qQqe
         MoY2/J+drkOIC0ySAoN/cWIGg8FYZq91M4PQ1BcfykwCHWYD9FaKAsdcouhx6LwPPE2p
         N5GuJecAihUDS/jE6ADf6TaA/JFWyHQUATFR2HmegKwxiXrj4iPxh15s0TvWLI4LEIO5
         pR/Q==
X-Gm-Message-State: APjAAAXHKem/xVGREo5RDnMU50Ipy1xcTIc0XbdgPL3tEnNTvKsjwyqP
        kZ64TOD/9DxMQQEAB3Ks1CE=
X-Google-Smtp-Source: APXvYqwae3ax93KZBruArMl2KQTDH37C9xXhwO6pqxhbJI70VmY7WfvIA2jEavLoCOMpZlxYqYsIWQ==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr502752pjk.32.1560362559537;
        Wed, 12 Jun 2019 11:02:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::c431])
        by smtp.gmail.com with ESMTPSA id s5sm127486pji.9.2019.06.12.11.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:02:38 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:02:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v3] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190612180236.GQ3341036@devbig004.ftw2.facebook.com>
References: <1560354648-23632-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560354648-23632-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 12, 2019 at 11:50:48AM -0400, Joel Savitz wrote:
> In the case that a process is constrained by taskset(1) (i.e.
> sched_setaffinity(2)) to a subset of available cpus, and all of those are
> subsequently offlined, the scheduler will set tsk->cpus_allowed to
> the current value of task_cs(tsk)->effective_cpus.
> 
> This is done via a call to do_set_cpus_allowed() in the context of 
> cpuset_cpus_allowed_fallback() made by the scheduler when this case is
> detected. This is the only call made to cpuset_cpus_allowed_fallback()
> in the latest mainline kernel.
> 
> However, this is not sane behavior.
...
> Suggested-by: Waiman Long <longman@redhat.com>
> Suggested-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Applied to cgroup/for-5.2-fixes.

Thanks.

-- 
tejun
