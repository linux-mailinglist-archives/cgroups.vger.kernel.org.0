Return-Path: <cgroups+bounces-6642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66801A4040B
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 01:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB3917A6E7
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867242D057;
	Sat, 22 Feb 2025 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mIQjMeCS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712C3D76
	for <cgroups@vger.kernel.org>; Sat, 22 Feb 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183799; cv=none; b=CUiSSmR6Bc2ZX2bzybwRe/zYPB2QRckL0Uy/r9SNp0AmJ6EzfTu2fmWgYCnh5RnKxly45RSe4mj+lUnENBb6mLmb7sqj3F75apZliLbcgP+d7QXewHBs7T50QF+pc7cl66LlmT1jIeKkKNfaEXuKcPhh1Q1B6o82+Lirq9PzwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183799; c=relaxed/simple;
	bh=IieG/8iX+NQtVDn1hM/IxY59Lqrb64+Z7mpGLWdYHPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/loHSOXJrKcItSmf5rMEtmidA6LkXidCin6lCZIHBYtBeDbEZdQ36yfmiDaF9dI8bBH94j2122ghp/XP5wSbKnNnmOhsr5gOza7HUF0xykPPFbZ3sGuiCRMsr3D7t/GNGi8QSr+2K9r7lz23Y9vSVHhdmVOKMHSqWoG4a43F2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mIQjMeCS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 16:23:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740183792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmBpQyE/HMZzPvz/HYmooqqofM5Sau8ZuGvHezOzH6c=;
	b=mIQjMeCSiQZyVcxGoy0CDPAHU44JsYv16c2372iAlrlBmc8tQN7r6+EIMp+CmETshQxZfD
	SktLhlR5Z03hMNxbTckwugVXKJZ5t5Fcqf4WVhcydaKQFBmrlWHDkc+u3IfiM8+atSDc34
	qTh/VTWs5aphKrYjGcP2GLp2JEOHlrA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 10/11] cgroup: separate rstat locks for subsystems
Message-ID: <em7lrcafldcdeb2lk3mydfmci3saletfkprc72p4elnlabcrix@6zije67tbpc2>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-11-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-11-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:47PM -0800, JP Kobryn wrote:
> Add new rstat locks for each subsystem. When handling cgroup subsystem
> states, distinguish between states associated with formal subsystems
> (memory, io, etc) and the base stats subsystem state (represented by
> cgroup::self). This change is made to prevent contention when
> updating/flushing stats.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

This looks good as well.

