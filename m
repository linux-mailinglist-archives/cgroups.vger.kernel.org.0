Return-Path: <cgroups+bounces-6062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F18A036D3
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 05:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AB41886616
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 04:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5691547E3;
	Tue,  7 Jan 2025 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jeI/VsGl"
X-Original-To: cgroups@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9213D638;
	Tue,  7 Jan 2025 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222799; cv=none; b=kKroH2tXcFx98CZkhcQ0SFTHVVKzOA0uYczLPBamuMFdNaryEglY0N+VklcYGnJQkxRJtvnKWFqMSyjf9BzDP/EWNI339uqxCyh+dfpG7lj9CEXfAEEXH+UfeGItnDKpQDq6OFjnH96KTxX60kzLdybuCsvApSKLCXfFVSLqUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222799; c=relaxed/simple;
	bh=s/p9dkodYxU2cpoFhNPHVzmpSDeXtSF0k6TjrLGeOcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru9z+SO4R393PPwkvidtG7mu1ievXjtrsFdAndatorilJjs+fe/IaH46INuGBo8MONv4Sfsgv4CLEgPYvweGVko7zIEza5+poGzeSJih/WhkbyJh3KfkbUXpPkcU6ld8juIM4jTkAu3O8e+bsAHCw/IYFv9RkXP8QMqBZGg53dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jeI/VsGl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m0JMwU97t9w9EN1iZ2e5OZiTPXXyjI7/akgnWZVa9bw=; b=jeI/VsGlhbYOxswSd9TmlJ1qUU
	ca38y7Oz57oWbhlXk3/DYhw517w0dZjY5QFcFf8icI2sYZQgyZy6HD6unLCpAHwhrNdpAhepADlL2
	myFst8rP9stsY1sDd8zHG/4sQ9skzyLRwj7jMyjRy1Tp25SgC+7cGpILrqJaBiI2Z12Q3uv63LJ8Y
	jGRIgLWIg4F5eEIelaaos+j+yIU2uNAR2Rdqp0fxsEweNnV4H+iGA0J6apsZgpC2fCqXB81h3ewI4
	oMLBxeFZzkPNZrNJ3uIiypd3p5SX2eTnYVlQuDNrC1zNJLvMeCiY3sB1mO3YPG4Fde2oBDHqAD5co
	Uops42aA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tV0rP-0000000GOfJ-0eyd;
	Tue, 07 Jan 2025 04:06:31 +0000
Date: Tue, 7 Jan 2025 04:06:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kenny Cheng <chao.shun.cheng.tw@gmail.com>
Cc: hannes@cmpxchg.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	c.s.cheng@realtek.com
Subject: Re: [PATCH] mm: avoid implicit type conversion
Message-ID: <20250107040631.GN1977892@ZenIV>
References: <20250107035141.2858582-1-chao.shun.cheng.tw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107035141.2858582-1-chao.shun.cheng.tw@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 07, 2025 at 11:51:41AM +0800, Kenny Cheng wrote:
> The function 'task_in_memcg_oom' returns a 'struct mem_cgroup *' type.
> If the compiler does not inline this function, a compile error occurs,
> as shown below:
> 
> ./include/linux/memcontrol.h:961:9: error: incompatible pointer to 
> integer conversion returning 'struct mem_cgroup *' from a function with
> result type 'unsigned char' [-Wint-conversion]

What does inlining have to do with anything?  And where has unsigned
char come from in that?
 
> This patch avoids the implicit type conversion by ensuring the return
> type is correct.
> 
> Signed-off-by: Kenny Cheng <chao.shun.cheng.tw@gmail.com>
> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..47acf1e4f5a7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1826,7 +1826,7 @@ bool mem_cgroup_oom_synchronize(bool wait);
>  
>  static inline bool task_in_memcg_oom(struct task_struct *p)
>  {
> -	return p->memcg_in_oom;
> +	return !!p->memcg_in_oom;
>  }

That makes no sense.  Do you have bool (or _Bool) defined or typedefed
to unsigned char somewhere?  If so, that's the bug that needs to be
fixed.

