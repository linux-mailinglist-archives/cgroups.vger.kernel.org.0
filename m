Return-Path: <cgroups+bounces-11292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFAAC16484
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405A35062F1
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07F34DCC7;
	Tue, 28 Oct 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smv/lP5o"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B134C991;
	Tue, 28 Oct 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673373; cv=none; b=W84HQkTmwXBkT0jJMFtBCrKVAeaSuj/s5ws2swGBb9b+zKVCgdbCIVQwsTOH38Dn0hmtr7RNiqKbOse8m8/F4v1cJP11TE3OVB0aSRLMH0CwEy4vt6IrJCD6BcqTan0pWbG8PWZDWlfHQXD4tX58gCbdfaSItLoA4RwVsMBywTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673373; c=relaxed/simple;
	bh=O9h35W/5qIeYiR+aZ394LJfEnSiQZLZpjbezvmnwe7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q15SzsgUuR3y8UhtEP8v/EXorvKG6HoOhyYYSWP2fbNZOiWQtpZqtLtJgaoFVxMsqXGvmR8CQvB+3967SKEnEG5GulYOrL3SvVdHrcop83twNA9LO8aaBIhM7VRZJXAnLXlIEts1nFuxMpAOGyOT8RFfsHi8QB7n3/lUAZZPArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smv/lP5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B7C113D0;
	Tue, 28 Oct 2025 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761673373;
	bh=O9h35W/5qIeYiR+aZ394LJfEnSiQZLZpjbezvmnwe7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smv/lP5o9CsLvG21j5v2Heg6EF/lysOnQHrQpZJiX8DtUg2Lq+g99CODEbIkkrZy5
	 OnjRJPcTk2LkvWjG2QWv+/uQ0Ww+4DXzENNaOCqTBqeroFUrss8437dc7sS66Uzdkd
	 saBHMOWXQZgMHK0ZAe1/AA+uB1En7rv2Aefwc7TpOhguU26if64+pyj6FMRBrldQyP
	 0jKG+7WgPyu8hiTKfkeJC+GIk/EtN71fzJen24goMLtLwd4sZbowqCWy+tNdr6/Ezc
	 3z5sSEESJtbWEZHhKs1Y7lcFapuO723akp7KCBJlKkXmJurqWZgGNzlgHNtz186X/3
	 +mbeVR8ykC8LQ==
Date: Tue, 28 Oct 2025 07:42:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg
 pointers
Message-ID: <aQEAnB7Gjs4vew8x@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-9-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-9-roman.gushchin@linux.dev>

On Mon, Oct 27, 2025 at 04:17:11PM -0700, Roman Gushchin wrote:
> +__bpf_kfunc struct mem_cgroup *
> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
> +{
> +	struct mem_cgroup *memcg = NULL;
> +	bool rcu_unlock = false;
> +
> +	if (!root_mem_cgroup)
> +		return NULL;
> +
> +	if (root_mem_cgroup->css.ss != css->ss) {
> +		struct cgroup *cgroup = css->cgroup;
> +		int ssid = root_mem_cgroup->css.ss->id;
> +
> +		rcu_read_lock();
> +		rcu_unlock = true;
> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);

Would it make more sense to use cgroup_e_css()?

Thanks.

-- 
tejun

