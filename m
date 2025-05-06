Return-Path: <cgroups+bounces-8030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB64AAB83F
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2421686C0
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68734AA86;
	Tue,  6 May 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEWOni/c"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF834D671
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746492781; cv=none; b=FcRKwhwVWpfoDVHzuDrCLPjH9GZ339zOSMWVexWl3YSgKYfx8bGTqRURqljuQhXT9qqh8LXehr6xwKBbGAMI/GYbh72/4G6lVWE+PqyXHltJZcaAVwL8gNOXKRUJUtlzjGt39bOTb2L22jjojdI30AFpLaOokuzMRRavj2PHtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746492781; c=relaxed/simple;
	bh=K1kVphxLlstWbzYfXsIS/lOtktofepVVkhjV5qI0Jmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMbe/1WW0VD6a/wYIaYvn5HJDS6o0tDWmZAEjunkDtg6lTbEj0gCWvvg+NM0WKwAvHOR/E6g+1t8YK/uBpmzyZEiF1pVZ6TPRPnoJMjny9FpbDJsX+meHghzJ9Ut+TjOjO6QjabnQ5opknhZSC9qnjHUNTENoW1WolWl6rHtBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEWOni/c; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 17:52:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746492775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uMO/jJfeqKj0Fwz6eS7ufThzG6Sk1XRMpQl7mFVrXo=;
	b=cEWOni/cxyk2LB9DEIVLmif7cXpdKXD/UZRUvFZw5SB6zJHplukMqcehNGFzO5Twq4JIW0
	uiFElKqC9XQnoPBNp8zGD9vMxqhgPXhD5Xt1jckVuBRDBjUaqgASNf668IF+GDYM4FwKJo
	t4Aa1eqy2YC4JciCKLfqrY7QwXv5Ngs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, yosryahmed@google.com, mkoutny@suse.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 1/5] cgroup: use helper for distingushing css in
 callbacks
Message-ID: <csncklc2vpsjra473n3ssay257alikuz4tthjii75gsywt7ue4@3opqvhdhu5eo>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503001222.146355-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 05:12:18PM -0700, JP Kobryn wrote:
> The callbacks used for cleaning up css's check whether the css is
> associated with a subsystem or not. Instead of just checking the ss
> pointer, use the helper functions to better show the intention.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

