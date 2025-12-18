Return-Path: <cgroups+bounces-12513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF9CCCBE9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 17:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34FC7307FC1F
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B804E364EBB;
	Thu, 18 Dec 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfaA/7lv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A807364E9F;
	Thu, 18 Dec 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074184; cv=none; b=iWYliqpX3aATxBkUatnTFaxVyr2tRfWsmDzt854vAT6HtVYczVxHtdfdvgMMgviSC94H2+/1TOhGtr7AqRN77CK40Gf+lVDB7qSa++1gLpoEVJ7QGe4zQCu6DUBOCp+wfYk+fXReQF1nCn4lYjHF9SH3Yrdx+tIXyJolw1vaOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074184; c=relaxed/simple;
	bh=OaX0M6d+7wMRlYS/BEZvp7zxg3HdWlfzOwJQjdKkB0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpiUCN1VHRhn7G2UVw3O8Ntxc6KWtE4swoF/m1jew0T4MBMD1AUfdugMD+uPhFqjBzTuqhcFRyTa+5wEumKetF20ISkuO9dk2WDSjwe9ea89LDBrzmpBA6sfTTq8EIUfqW//KfZ959gy0LcnKbho7NGXan5hLEdQP20DnJfDKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfaA/7lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCD6C4CEFB;
	Thu, 18 Dec 2025 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766074183;
	bh=OaX0M6d+7wMRlYS/BEZvp7zxg3HdWlfzOwJQjdKkB0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfaA/7lvQ4zwujLRnNiSihgZPv9+hb3oQujvQCQ7MbSfuq5VjHVuk92ousa78YHGq
	 IlVft4liH03uKYNTHhHiOxm+p/nB322TQCTuXPAA2JdfNdZPMykmvui88q2njJybTU
	 CdaWDv1JSzE3eY+q0KCN3bknpZRv3ZWa6ivoOJvOWGDb8CGrO/GCUxS4NY+bcqxQNG
	 8UVzCrD759+mFttAVLQh+I/S9/wXlHu+XW9KMbQm0J0ZRDKKdog3xp2AvS7tJPzszC
	 CMx36v8HjnDa0xBvWhaAUXL1khoSmQ6D/nzh/ddVaC2GxolhagP4dF2LjwQpZCpTyR
	 SzxBTTNW3laOg==
Date: Thu, 18 Dec 2025 06:09:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
Message-ID: <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-4-mkoutny@suse.com>
 <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>

On Thu, Dec 18, 2025 at 03:09:32PM +0800, Chen Ridong wrote:
> Note that this level may already be used in existing BPF programs (e.g.,
> tools/testing/selftests/bpf/progs/task_ls_uptr.c). Do we need to consider compatibility here?

That's a good point. Is __counted_by instrumentation tied to some compiler
flag? If so, might as well make it an optional extra field specifically for
the annotation rather than changing the meaning of an existing field.

Thanks.

-- 
tejun

