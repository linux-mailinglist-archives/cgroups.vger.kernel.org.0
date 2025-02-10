Return-Path: <cgroups+bounces-6475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F951A2E6B2
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 09:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5E67A37C9
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA81BEF71;
	Mon, 10 Feb 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R4Nz+1Og";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0ARSOsA"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF31BDA95;
	Mon, 10 Feb 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177023; cv=none; b=NcVPc3GG6UgkCafLZhWVH38rh/x8Em2CnQE0fIUgs2r1rsPChW53trhakp/Sh+Pg7cyqnv0uzP6e3ndKGK8Jo7OStl4QN+EwMm3j0LSnmnmEUFNhIAk+J+I3YGnXM2HnyTu5rahklMKvsO6JQxgUxFrYam8yuLGNHBimBFK7Ca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177023; c=relaxed/simple;
	bh=Mdg0SrPX+N0sJvGRpoqt/A0aLHrXFS32YIG1eZopRI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjXDQBfYJFAIMa4Qc/wyvWkomtwJyru93Gx4Eq0b1oh6/v6occebSvBITT8mVxDUECRl1l3V40/j0dKKp/99i5uDnBZ/visuPkXQ0xXSQMPiXSQYZUxe0ohNiTC9OqUL60IB2UCCdGIWgwaXTABNbbOLVNjw9WSnCr96s9PnAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R4Nz+1Og; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0ARSOsA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Feb 2025 09:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739177013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIuRcjptjh9/AMgIrM80ZU522dtLicptkr1+Q41B1sE=;
	b=R4Nz+1OgIWm/jaJ40jwvDEJHT0xx6tsCC8J2gX+2mQTo+oBAmRxO6UokMjwj/IYy33qYOA
	UALDMy1n83bp2tBYJ63ObnptX0CCTzXxql0psHe4MwnMmmAN0ETpzGvSsNEJkzfbANBIvX
	jdn7czu/GuLkDZArqYBV3A3wzYxxKc8Em4jFLF1lZPqoWf6cRkxGcmT2KqBAsnHRTbllNa
	bkdaRpPb8luWXjWIaFnRpsG691WEu8IPzyrSvl6bhFdczyDtaubgf+iQp1VOTpHZo2aaVQ
	DRpcHsrnKohSa//0a08k+OoBhEh6B/rgj95X4E9NgfeWzn5s7PMrQuHA84OWXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739177013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIuRcjptjh9/AMgIrM80ZU522dtLicptkr1+Q41B1sE=;
	b=s0ARSOsALs0PNUGuLU7s1AfucQpyJovs44nzK0JRkeXQ3tDazfk0Q491HyzlAuTiLiojBC
	OZF1Dn4qxpHH+eDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>,
	tglx@linutronix.de, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v7 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <20250210084331.IJB3qKdl@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
 <20250203135023.416828-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250203135023.416828-6-bigeasy@linutronix.de>

On 2025-02-03 14:50:22 [+0100], To cgroups@vger.kernel.org wrote:
> kernfs_rename_lock is used to obtain stable kernfs_node::{name|parent}
> pointer. This is a preparation to access kernfs_node::parent under RCU
> and ensure that the pointer remains stable under the RCU lifetime
> guarantees.
=E2=80=A6

The robot complained that the selftests for bpf broke. As it turns out,
the tests access kernfs_node::{parent|name} and after the rename
::parent is gone so it does not compile.
If there are no objections, I would merge this into 5/6 and repost.
"test_progs -a test_profiler" passes.

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testi=
ng/selftests/bpf/progs/profiler.inc.h
index 8bd1ebd7d6afd..a4f518ee5f4de 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -223,7 +223,7 @@ static INLINE void* read_full_cgroup_path(struct kernfs=
_node* cgroup_node,
 		if (bpf_cmp_likely(filepart_length, <=3D, MAX_PATH)) {
 			payload +=3D filepart_length;
 		}
-		cgroup_node =3D BPF_CORE_READ(cgroup_node, parent);
+		cgroup_node =3D BPF_CORE_READ(cgroup_node, __parent);
 	}
 	return payload;
 }
@@ -300,6 +300,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_=
data_t* cgroup_data,
 	cgroup_data->cgroup_proc_length =3D 0;
 	cgroup_data->cgroup_full_length =3D 0;
=20
+	bpf_rcu_read_lock();
 	size_t cgroup_root_length =3D
 		bpf_probe_read_kernel_str(payload, MAX_PATH,
 					  BPF_CORE_READ(root_kernfs, name));
@@ -323,6 +324,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_=
data_t* cgroup_data,
 		cgroup_data->cgroup_full_length =3D payload_end_pos - payload;
 		payload =3D payload_end_pos;
 	}
+	bpf_rcu_read_unlock();
=20
 	return (void*)payload;
 }
--=20
2.47.2

Sebastian

