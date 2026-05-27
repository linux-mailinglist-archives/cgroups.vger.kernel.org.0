Return-Path: <cgroups+bounces-16342-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLOED/WwFmokogcAu9opvQ
	(envelope-from <cgroups+bounces-16342-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 10:53:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61D5E15EC
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 10:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4787C3056FEE
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B33E2ADA;
	Wed, 27 May 2026 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VRjMtZnp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EB3E2AD1
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871646; cv=none; b=Fl+YgVJOLa78r9GF9rtMpkl4mEXnz4WTVA/Qm/I49NgubyxYNym7m/zQ5wpskfXEOg31cGqqSvoMwfY1JXcSoC15Ez4X+BKGS7jpeTrvZ152mhkO9eZfpdZeIuYMN6yM/3zOWbox//nOAILrLZ7OKnFsWOsZCTu9faAdwobMp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871646; c=relaxed/simple;
	bh=+S4VYKZ9ptdmSKpoyw5zEZ0qC9zK3GWuSXvh/IZacBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucfQ6AB/Hm5PdiiJCbQ8/4270TH/Z4IgcrBT8XJumCJNgbxfpJK5sJ3cUXEaC8WfXxCUzTyRlpvdN7w57XE53zm/M+AkpvwziqlltlvMoKeCvVuA3qc5csIQuqJ2pvzBi/XUlEAHE8/TT6hltR3kMQ9qus1xu12+fOtm2C7J6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VRjMtZnp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso50906345e9.0
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779871643; x=1780476443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvPbiO/kvHgyF1x18sRDfpJ1LTwDqRquW88o+S2pTM0=;
        b=VRjMtZnpCKOcXcOF9DTMgqBezQRg/M94etjreoP0KPFMjPt2kMWgqAUEKwNHTRLZk4
         oY64omlnIYFtPHTVkffnvv7lQLndypfYNUl0HsubOgZ61xs4tkAK8SQRTa08Qi2m6nso
         yks9j0LgvYs/4UuQJBAnrQ2pkHiWYjBKnwQyn8JkgRCIslpcxkg2WrHBf2H93O3OD7rG
         mRF5ESWiVzPTC0mh8erPuu3+P1rLE9StT5ocRa6LIaJpUy5xAA5jfSDjqjWxAQZq8Ox3
         RtHohIqiSiblGpByGNRwYkS2BP1veVP+MW5/xc3EVZJJAMzAIR9ElsG1kVeidqb4ZlZy
         Dq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779871643; x=1780476443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvPbiO/kvHgyF1x18sRDfpJ1LTwDqRquW88o+S2pTM0=;
        b=oimvrf0Kylm1c8Ykvkhl7GyPVUEyeihV8JKiZAkiA2dJXhv0oxZdYG9HY38p123xAC
         ZeF4k0971B3Qfz4BPztK0YJV6ANyUTnFxy7lCpCS2spZENHdtH2+cGHGdAv55862Zx1F
         0DpIDTDKuFSorGl4ogOGi2BJKX+2ICVym6B3ZTRilsqjEoS0gRX2//fptQ33Rg/RjLQq
         wbQdN9mp7xh4hi926KdINSiaIzZ3/Vz1MJHGOv5WbqmWmiptk9Gx+DhEH8NeJoGxI0E3
         VrcE5vmOMCQKkvTitBQ22CAcaksEV9CYIxtu69hGNxGt4ZUFcfj/ujEa3vCcGSbB7uR+
         AZIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SRtZZYyNqROx4inF94RM5UrPVbdevxNz70PV6LsOfJgBE5U1IrKjz/Z71/cpxBQKzvYD4TXSz@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMpuekBPzZoyyq9vT4NbB0a5NR0GrCTpYE0biRHdOJjlYS3Zb
	QQMAWtz8hbdGLa+aPJv8AuHtta1X2zdn741809DKpW/NiOnuE6GgmYwSAQnlPbz6MAs=
X-Gm-Gg: Acq92OEfMc4jCRGbT0TDjmbvXtvxInRRNzC62/VOWgJXE8xTNDME2J5KJMad+SKa9x+
	II1KmghXMCFJ8YFVr7/e0KFGRORETJqOcsyJz89nrDvitf/yCW2N+w1haug/gvWuSHHBRTZv0vv
	eFymiU/EaZR4CgPwvnHMv2hsvTCm0vabUS3DeZQOmQVhPrDGDcMO4SLKAzUNTNmEqpgTCoZ0NTD
	eCZmPH9nDyfMsmaFfN6fxzJM939S1Eh+KpoxqdDeIDWguRCVg5YHh9+ieIE22wJ3kpjSs9nUeWp
	SL9HH5kjGjNWKiYl83IQQmmVPGkue7KMo9AC8DMg5m2TD5eYNmEkydrKgr2AkOkd+yD+/eDrCFL
	rBb20irH+IbRMJfr2RWkoeguntPHC9Iju0h3e48+nTcdFzJbqH9CJSSqXtnkbsxh/7vAeO2gb13
	l/jMlHe57gdyf9xFPEA1Eld/M1F2ipehW42zkKn5ru+yG3
X-Received: by 2002:a05:600c:a402:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-490426d1a91mr259475015e9.19.1779871643182;
        Wed, 27 May 2026 01:47:23 -0700 (PDT)
Received: from localhost (109-81-80-71.rct.o2.cz. [109.81.80.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098f315sm12090405e9.16.2026.05.27.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:47:22 -0700 (PDT)
Date: Wed, 27 May 2026 10:47:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, KP Singh <kpsingh@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Eyal Birger <eyal.birger@gmail.com>, Rong Tao <rongtao@cestc.cn>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	geliang@kernel.org, baohua@kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 00/11] mm: BPF struct_ops for dynamic
 memory protection and async reclaim
Message-ID: <ahavmbcdXDX5gNup@tiehlicka>
References: <cover.1779760876.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779760876.git.zhuhui@kylinos.cn>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-16342-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD61D5E15EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 26-05-26 10:20:00, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Overview:
> This series introduces BPF struct_ops support for the memory controller,
> enabling userspace BPF programs to implement custom, dynamic memory
> management policies per cgroup. The feature allows BPF programs to hook
> into the core reclaim and charge paths without requiring kernel
> modifications, providing a flexible alternative to static knobs such as
> memory.low and memory.min.
>  
> The series enables two complementary use cases.
>  
> Dynamic memory protection: static memory protection thresholds
> (memory.low, memory.min) are poor fits for workloads whose actual memory
> activity varies over time. A high-priority cgroup holding a large working
> set but temporarily idle will still suppress reclaim on its siblings,
> wasting available memory. A BPF-driven approach can observe real workload
> activity -- page faults, charge/uncharge events -- and activate or
> withdraw protection dynamically.

Why the same cannot be achieved by dynamically changing protection?

> The test results at the end of this
> letter quantify the difference: in a scenario where the high-priority
> cgroup is idle, the BPF-controlled low-priority cgroup achieves roughly
> 37x higher throughput than with static memory.low.
>  
> Asynchronous proactive reclaim: the memcg_charged and memcg_uncharged
> hooks, combined with the BPF workqueue mechanism and the new
> bpf_try_to_free_mem_cgroup_pages() kfunc, enable BPF programs to perform
> proactive background reclaim without blocking the charge path. The
> pattern works as follows: the memcg_charged callback tracks accumulated
> memory usage; when usage crosses a configurable threshold, it enqueues an
> asynchronous work item via bpf_wq_start() and returns immediately without
> throttling the charging task. The workqueue callback then invokes
> bpf_try_to_free_mem_cgroup_pages() to reclaim pages from the target
> cgroup; if usage remains elevated after reclaim, the callback re-enqueues
> itself to continue. This allows a BPF program to keep a cgroup's
> footprint below its hard limit (memory.max) entirely in the background,
> avoiding the OOM killer or direct-reclaim stalls that would otherwise
> occur.

How do you account the overall work done to the specific memcg as the
large part of the reclaim is done from WQ context?
Also when introducing a BPF hook please focus on describing why existing
interfaces fail to achieve what you need. For the async reclaim why it
is not practical or feasible to use userspace driven memory reclaim.
-- 
Michal Hocko
SUSE Labs

