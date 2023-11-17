Return-Path: <cgroups+bounces-462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4897EF3D1
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 14:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7E3281411
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC794328D1;
	Fri, 17 Nov 2023 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBC31593;
	Fri, 17 Nov 2023 13:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A0EC433C7;
	Fri, 17 Nov 2023 13:47:59 +0000 (UTC)
Date: Fri, 17 Nov 2023 08:47:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
 <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, cgroups@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] kernfs: Convert kernfs_path_from_node_locked() from
 strlcpy() to strscpy()
Message-ID: <20231117084757.150724ed@rorschach.local.home>
In-Reply-To: <20231116192127.1558276-3-keescook@chromium.org>
References: <20231116191718.work.246-kees@kernel.org>
	<20231116192127.1558276-3-keescook@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 11:21:25 -0800
Kees Cook <keescook@chromium.org> wrote:

> One of the last remaining users of strlcpy() in the kernel is
> kernfs_path_from_node_locked(), which passes back the problematic "length
> we _would_ have copied" return value to indicate truncation.  Convert the
> chain of all callers to use the negative return value (some of which
> already doing this explicitly). All callers were already also checking
> for negative return values, so the risk to missed checks looks very low.
> 
> In this analysis, it was found that cgroup1_release_agent() actually
> didn't handle the "too large" condition, so this is technically also a
> bug fix. :)
> 
> Here's the chain of callers, and resolution identifying each one as now
> handling the correct return value:
> 
> kernfs_path_from_node_locked()
>         kernfs_path_from_node()
>                 pr_cont_kernfs_path()
>                         returns void
>                 kernfs_path()
>                         sysfs_warn_dup()
>                                 return value ignored
>                         cgroup_path()
>                                 blkg_path()
>                                         bfq_bic_update_cgroup()
>                                                 return value ignored
>                                 TRACE_IOCG_PATH()
>                                         return value ignored
>                                 TRACE_CGROUP_PATH()
>                                         return value ignored
>                                 perf_event_cgroup()
>                                         return value ignored
>                                 task_group_path()
>                                         return value ignored
>                                 damon_sysfs_memcg_path_eq()
>                                         return value ignored
>                                 get_mm_memcg_path()
>                                         return value ignored
>                                 lru_gen_seq_show()
>                                         return value ignored
>                         cgroup_path_from_kernfs_id()
>                                 return value ignored
>                 cgroup_show_path()
>                         already converted "too large" error to negative value
>                 cgroup_path_ns_locked()
>                         cgroup_path_ns()
>                                 bpf_iter_cgroup_show_fdinfo()
>                                         return value ignored
>                                 cgroup1_release_agent()
>                                         wasn't checking "too large" error
>                         proc_cgroup_show()
>                                 already converted "too large" to negative value
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/kernfs/dir.c             | 37 ++++++++++++++++++++-----------------
>  kernel/cgroup/cgroup-v1.c   |  2 +-
>  kernel/cgroup/cgroup.c      |  4 ++--
>  kernel/cgroup/cpuset.c      |  2 +-
>  kernel/trace/trace_uprobe.c |  2 +-

trace_uprobe.c seems out of scope for this patch.

-- Steve

