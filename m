Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C24285F9
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2019 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfEWSff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 May 2019 14:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731261AbfEWSff (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 23 May 2019 14:35:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F8321019;
        Thu, 23 May 2019 18:35:33 +0000 (UTC)
Date:   Thu, 23 May 2019 14:35:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukas Prause <langspielplatte@black-mesa.xyz>
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
        Lennart Glauer <mail@lennart-glauer.de>
Subject: Re: [PATCH] Fix comments with paths pointing to renamed or moved
 files.
Message-ID: <20190523143532.0319e253@gandalf.local.home>
In-Reply-To: <20190521155430.14941-1-langspielplatte@black-mesa.xyz>
References: <20190521155430.14941-1-langspielplatte@black-mesa.xyz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 21 May 2019 17:54:30 +0200
Lukas Prause <langspielplatte@black-mesa.xyz> wrote:

> This patch corrects renamed or moved paths in comments.
> 
> Signed-off-by: Lukas Prause <langspielplatte@black-mesa.xyz>
> Signed-off-by: Lennart Glauer <mail@lennart-glauer.de>
> ---
>  kernel/cgroup/cpuset.c       |  2 +-
>  kernel/locking/mutex-debug.h |  2 +-
>  kernel/power/power.h         |  2 +-
>  kernel/sched/core.c          |  2 +-
>  kernel/trace/trace.h         | 14 +++++++-------

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  5 files changed, 11 insertions(+), 11 deletions(-)

