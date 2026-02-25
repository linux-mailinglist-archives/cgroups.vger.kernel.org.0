Return-Path: <cgroups+bounces-14311-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aClmCFWYnmnXWQQAu9opvQ
	(envelope-from <cgroups+bounces-14311-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:36:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDEB192690
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A49053051CAB
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174582D77FA;
	Wed, 25 Feb 2026 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHahVUkK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rOa8MY8f"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8F2D0C82
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772001294; cv=none; b=Wdl7rEqfRmQ0Nu2OEmE/tWspdhL0LHJnKiLvz0/X5T8GJfKVkkhLmBH3WMY2K+0GdDEv6hCzE0Vae+9kD/GBzibuOPxk8LkSX2hFf70UznyroaAeF5bThGqr0hV3/zwvGvgl/vGrPFoUk6fHrLkjieHuT8/X3bXpOpRESISkl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772001294; c=relaxed/simple;
	bh=KLxBg42SI5qqJn6x0Aw56CWo8tZSqLljrMc3PY2v1i8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lwCXKYrIPr+Cxgr+04r3uY0plnhTcE8RQKE1vqPmebFu68AwLi79W/43A3Izj2HYcjd6wwY+KHzdldlVz8OJVJo28qLGXBAj8l74DTrthq4WLmH5Y/LUWhln1vD+0OPZRSN9ePtApksDTX+qFpypWcdxe4bakBnlWi95Mgs3EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHahVUkK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rOa8MY8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772001292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLd2XQBnJ1Hr7SICN8JmqPACHbkEFAOR+6MAVERvw6M=;
	b=CHahVUkK5BK9G8O4sSaFMX+yu/qTD2W3JBfmPHJ0x00zdSO8yURpeyHPkudW4HgfdHd7Fl
	5JOwAIn4f9+Alc5e2LsNIDceklujoq65dDu+PcI/J0lMMX/wlFPgfQR/HrpaL3NIyGXblT
	UuZG/0t3xnhus4dCvc9yUMrc5gBoJVk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-UNjBSk8CO2WKW4VJBfZzAw-1; Wed, 25 Feb 2026 01:34:44 -0500
X-MC-Unique: UNjBSk8CO2WKW4VJBfZzAw-1
X-Mimecast-MFC-AGG-ID: UNjBSk8CO2WKW4VJBfZzAw_1772001284
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506bac14430so447474691cf.2
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 22:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772001284; x=1772606084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pLd2XQBnJ1Hr7SICN8JmqPACHbkEFAOR+6MAVERvw6M=;
        b=rOa8MY8fAkv5VWjz+wzkHMgD6HUbrzcHEw2SpIlZVnktzNn35WajCeFsoQ5F8z6XXo
         RUnvXeo8X4XozF8JoTWOXm2Tb7jgyTUe6V4kEZ8SLf4ZMGQe63/9wmMFXdHGD1V0tYsi
         G6oShNrJ1IjEjE7QfssVh/MGYiXjb9ESFRKuXfpk2macG2eJ6L3MIcP9/xBIzxzDHWn8
         LHMsu2yovG/uK+AFb0oW2kYeCkjLYtD0+4kZdePq4k97DYffAojaaBVGhVmC0fWePj8i
         x1E8MIxebtrQL/2JBLJur+BJCJiJB3RfAoHfoOhvVMO0cOVRBIEg/VexOfxbv1Aujqy2
         hbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772001284; x=1772606084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLd2XQBnJ1Hr7SICN8JmqPACHbkEFAOR+6MAVERvw6M=;
        b=q131kwa2IfoPuUh74G+ShMWhAuOoSOFwrOAOno4HI7PwDaaOtecShgB2M9gcvViGVg
         wsOMIiB9OKt6KSgZ7+8SjtzL5Y+KbRFt3y4ro/bcP6It202AGqxXIYxD5t/At8k3U1AD
         qHqSMSclSIqnJINZ9Zb/hdb6qHYmARRglnCHW9eBjGxScbmeCQ7Y6tlIQU+ClvClP/X1
         Y/qPvGsNS9Jhraqt2acqjRmQ8BHvCGSVxFH4FeBOou9T10w7ph5rFN8L7B1JTzA93YXF
         HsuyWgatpssA50IrTFeC/8y4ZGFBKAxdqRrHQjL/bp6in5H66mGdzKFNjjOQn51q+SPf
         7/Yw==
X-Gm-Message-State: AOJu0Yzpzdx5c6HKukl2YLanTHNz36PMiwP+8FMwo/etLIDPPTDXK+VW
	se0/SsXKvg+c6Vhuc+HFvccUg8sNG9mtqWrY62H4J/fPihb6RCswcI/rFZNk5bIlUoaQOQf2z4g
	95PQPwvBINTcOfsYEWZVCwgPnBaSuclYFj/6k9CxGleKEU5qAbC4V6yTzXT3Pf8Ed2x4=
X-Gm-Gg: ATEYQzzSphl5RzIwlbO3ZG/+3u8Lx11mzuHL5ebf/WeFdyQPLJ3dYL3PkcJ6GAipaet
	Q1e7n48VORG5odOQUIMHDFb6SR+kN0PQWQkW6klElvnnUC75hVFSFwCYC9J6eZqKW5wwqDLjGXv
	rJoRPB0C10LGOqm+Qs27QQ6r//Dw73EHztdNAJWSq6saYucxBr2s6a1VlaRzWG25/4H0b9fEr0x
	BSc7oxbsU6U6YbuKl7jZeh67SkTsGJT+XA33ibqbNbmN+mIYCBKED+2zKsdLbYQAccp73l7pi0A
	4c67Lj4sF4kER925i7jlAuWrTq38UdhkfQqG17bXqXtWufdVlzk0aWhwnxGh8jJeCCYmcBoaNjB
	HX0KEvsNW9Fr5k0/VqP3hQpoZn4s+Vg2bajvKY3vXX0N5ERbDQPVeBw5bG0euMPFVMlOO
X-Received: by 2002:ac8:5854:0:b0:503:2f49:6f81 with SMTP id d75a77b69052e-5073a35947amr15070891cf.74.1772001283990;
        Tue, 24 Feb 2026 22:34:43 -0800 (PST)
X-Received: by 2002:ac8:5854:0:b0:503:2f49:6f81 with SMTP id d75a77b69052e-5073a35947amr15070721cf.74.1772001283586;
        Tue, 24 Feb 2026 22:34:43 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d550785sm143966001cf.11.2026.02.24.22.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 22:34:43 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <35c806f0-39ba-42c2-87f2-f3f3a6772ed2@redhat.com>
Date: Wed, 25 Feb 2026 01:34:41 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: fix null-ptr-deref in
 rebuild_sched_domains_cpuslocked
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260225011523.51365-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20260225011523.51365-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14311-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 7FDEB192690
X-Rspamd-Action: no action

On 2/24/26 8:15 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A null-pointer-dereference bug was reported by syzbot:
>
> Oops: general protection fault, probably for address 0xdffffc0000000000:
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
> RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
> RIP: 0010:rebuild_sched_domains_locked kernel/cgroup/cpuset.c:967
> RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
> RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
> RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
> R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
> R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   rebuild_sched_domains_cpuslocked kernel/cgroup/cpuset.c:983 [inline]
>   rebuild_sched_domains+0x21/0x40 kernel/cgroup/cpuset.c:990
>   sched_rt_handler+0xb5/0xe0 kernel/sched/rt.c:2911
>   proc_sys_call_handler+0x47f/0x5a0 fs/proc/proc_sysctl.c:600
>   new_sync_write fs/read_write.c:595 [inline]
>   vfs_write+0x6ac/0x1070 fs/read_write.c:688
>   ksys_write+0x12a/0x250 fs/read_write.c:740
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The issue occurs when generate_sched_domains() returns ndoms = 1 and
> doms = NULL due to a kmalloc failure. This leads to a null-pointer
> dereference when accessing doms in rebuild_sched_domains_locked().
>
> Fix this by adding a NULL check for doms before accessing it.
>
> Fixes: 6ee43047e8ad ("cpuset: Remove unnecessary checks in rebuild_sched_domains_locked")
> Reported-by: syzbot+460792609a79c085f79f@syzkaller.appspotmail.com
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 9faf34377a88..8ebf2ab8f0df 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -962,7 +962,8 @@ void rebuild_sched_domains_locked(void)
>   	* prevent the panic.
>   	*/
>   	for (i = 0; i < ndoms; ++i) {
> -		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
> +		if (doms && WARN_ON_ONCE(!cpumask_subset(doms[i],
> +					 cpu_active_mask)))
>   			return;
>   	}
>   

I would prefer putting the doms check in the for loop without the line 
wrap, but that will work too.

Acked-by: Waiman Long <longman@redhat.com>


