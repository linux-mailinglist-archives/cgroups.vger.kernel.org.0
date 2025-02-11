Return-Path: <cgroups+bounces-6496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA4A30500
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 08:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515533A65D4
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1694F1EE7D5;
	Tue, 11 Feb 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IABUBRnd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rxJqixZq"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245B1EE034;
	Tue, 11 Feb 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260624; cv=none; b=Nc5ldcN5muYo8wD3TxwEHiRgF//5ukYlG3bHg9GfvR1u+jlP2ydedtiLzCn5WJBBPYHXEvGhCEabqEbnsXH1wocYi7JhlzjHM6q+7sAOO5Qtp6nXSpWkt1aKFHeNUBJ0Pr7PybUx03UgNL/YP5jTv90P4AUY7zB88P/WkVkzsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260624; c=relaxed/simple;
	bh=IEmUAN2REYIGOmF/Qcd2V37ijy2+yalXDI9v36yAONs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gezyoQfl528klCXnTrsajK9fJT8YAGCep7s/PrleYkbJ5XNOeMKM9QBIAHvlHpOsV3G9At0QT7htsEHmtUC197aFxfhKHNKUf1mfgcFi93wu/7X7yOV8y1+GjKemcVQrqSulSRGoYk7ccaC3VvavB+VJsogpO/rxk0NPqZiPtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IABUBRnd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rxJqixZq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Feb 2025 08:56:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739260621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbggBS30HzStlwARtU+mSUGuU8Rb52teg6Heb0c5gFU=;
	b=IABUBRndOMOeEdwt3mrQwfnYUQTo8+H5JH2+kDzliQ7le2FLyiaZ3ldQh0EOrADdE3cbAw
	hHdim8SW64+nHLCZTStUKoiYLMUe4xiZs6EhKJxiTS7MYbGolInr1RiRJ91khg1/XcYe+5
	Psm+7K4JkXFJ1oN9mF3pkLYkv0x0M29nJ6KCrNjjlEjKEGe8JXPRX1D++Z06gLXJqPHo/K
	bqk0fuEIAr7B2V0VKEIcvoecRNQiMTn58LhcF5DEIKhu+zU+d6kmi082jgqgao22hDprnz
	sdI5JOvxqR75KNzA2FwUQ9PT3Q14VQcodvkqdjVhZShsDz6OWaeXRw0yxGt5Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739260621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbggBS30HzStlwARtU+mSUGuU8Rb52teg6Heb0c5gFU=;
	b=rxJqixZqX9nHMFYk21/KatyWkffrPpHEuHfzA+kq/HJe/0rz+VL834OEfkbitKCVsNVsrE
	tMIXSEem8yqq/EBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
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
Message-ID: <20250211075659.aRpNJSdP@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
 <20250203135023.416828-6-bigeasy@linutronix.de>
 <20250210084331.IJB3qKdl@linutronix.de>
 <cab1d59c-4dac-4a5b-8dfa-43c2ac03b675@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cab1d59c-4dac-4a5b-8dfa-43c2ac03b675@linux.dev>

On 2025-02-10 08:41:00 [-0800], Yonghong Song wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
> > index 8bd1ebd7d6afd..a4f518ee5f4de 100644
> > --- a/tools/testing/selftests/bpf/progs/profiler.inc.h
> > +++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
> > @@ -223,7 +223,7 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
> >   		if (bpf_cmp_likely(filepart_length, <=, MAX_PATH)) {
> >   			payload += filepart_length;
> >   		}
> > -		cgroup_node = BPF_CORE_READ(cgroup_node, parent);
> > +		cgroup_node = BPF_CORE_READ(cgroup_node, __parent);
> >   	}
> >   	return payload;
> >   }
> > @@ -323,6 +324,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
> >   		cgroup_data->cgroup_full_length = payload_end_pos - payload;
> >   		payload = payload_end_pos;
> >   	}
> > +	bpf_rcu_read_unlock();
> 
> All programs calling this function populate_cgroup_info() is not sleepable program
> so the whole prog is protected by rcu and there is no need for above
> bpf_rcu_read_{lock,unlock}().

Understood. So just the rename then.

> >   	return (void*)payload;
> >   }

Sebastian

