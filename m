Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFB42BAF
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2019 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406982AbfFLQCr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jun 2019 12:02:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40860 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406604AbfFLQCr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jun 2019 12:02:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so6634906pfp.7;
        Wed, 12 Jun 2019 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/SueBbtj7C5fFQ+1HnrwXXVgHlOaQMtNQZKJDih2vk=;
        b=O2IfSoEdPeOtqvYc61BZ6k3//eUBsMkInNpkQAdhysvx5DQ3SdYRIa4kcfKFNZZiUf
         gnZiXeSVkjhFpwuXlNh0ekQU9A13LIBL1boBvvOujQQdHY6GA0eSL5Gnqvg6nq8Nfeuc
         3fp+jTtqUacUT5N2RJ51BAY8KHD3RLw3T0WANZ7Fdcv8ap6gs4icNXGB8NJwKRnjHgbx
         5lD/T9jSf8m6NvX1y/agOfMFhQMjhe9A0JGL45PHag1/zVPKZOOpYu8c3TGhLn+7hxSO
         UoCiIyN+Kca/fLHpXlP7m4CqcwCd5anviByK0K7OR9KQ3wgNCj125XtlSdLups1CYqYK
         GJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/SueBbtj7C5fFQ+1HnrwXXVgHlOaQMtNQZKJDih2vk=;
        b=QkZKCTJgO+CRCncQ+ZB0St41hMjdD9sz251zs0EQUzh5kXC8B/ntA3HOmjeNkoZACJ
         HnmiDHOUuA4VyMexl+O9vUkCUGJcS9hbzCuZMJN5+UmGkpjLgQXGGJeC5MVeY02VFFYe
         IcO1A1/QfT1zOD7zmcXGj1Ah5Qo74PyKYaEXmujEoF5rqrJ6XGwvTHqE0rwFHeRrd0SS
         XwFPpNejsvqM+CqcVYlFnaJzttvm2ZPnBNoQk35qqxCWlKghdAlwSGMQ5FBm6YkuFmLU
         U2Fyl4E9AJYn1wBWPcMuLQTfqOP0A37oaun5y2AXuXNgFueOPvvMio6qcHq7YTBTd7nw
         mjqQ==
X-Gm-Message-State: APjAAAWxjq5umXq+CbN6NO6YbCqSzin2dkEAKcC79EnPL+SJ9J5VxGbL
        OtvJZGAXYQ8g8oKrzo3xY7o=
X-Google-Smtp-Source: APXvYqxG8p2oJB3BYWG5XIejEtw3Ow6zJoP+BBfkx5+yZm7Z3tUHMhdrYVY2YkHPFCPijmjru4t8NA==
X-Received: by 2002:a65:484d:: with SMTP id i13mr25259329pgs.27.1560355366687;
        Wed, 12 Jun 2019 09:02:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::c431])
        by smtp.gmail.com with ESMTPSA id d187sm14370pfa.38.2019.06.12.09.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:02:45 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:02:44 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v3] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190612160244.GP3341036@devbig004.ftw2.facebook.com>
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

While not perfect (we'll need to stop updating task's cpumask from
cpuset to make), this is still a signifcant improvement.

 Acked-by: Tejun Heo <tj@kernel.org>

If there's no objection, I'll route it through the cgroup tree.

Thanks.

-- 
tejun
