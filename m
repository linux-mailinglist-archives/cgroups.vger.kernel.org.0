Return-Path: <cgroups+bounces-4888-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B728979C29
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADEEB21C4C
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF21386B3;
	Mon, 16 Sep 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DQToUKuw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39C3E47B;
	Mon, 16 Sep 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472501; cv=none; b=WxzFOFqVDZy8tKjmhRRTk1c10OuKJz3ZqSlwHLa0ng7v6ZjX8cuLHWqoVzoYRN2ibDXR8JhAxALy6XBajeEOawTdNf60QW86jfaMNAcuhTxyzPS2ae36xnlElZvaDuIQzyOytiKEIXEQy/MEcgeRDRikJj7kxeOeTSJA6C2WOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472501; c=relaxed/simple;
	bh=MJNU64e/Cm28j4kruSrPIYGA0DU5DT4s0QKn5OFOK0w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H5mlldPT72pst4lLxlopvrtdkRDFaJs9EAokXh6yPvX94Mp2L+n8+frTBbCcwQto/UuSGBDCsXOZfCvWSaDX0Ad9IbHO8lZB1mCjBM+Rf7rtfEJwasu5PPTcK6YKVxvxDrGXsEnxvQZYbNRIDmQhfrYhlOmvnKlYkZz4IuuFCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DQToUKuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED106C4CEC4;
	Mon, 16 Sep 2024 07:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1726472500;
	bh=MJNU64e/Cm28j4kruSrPIYGA0DU5DT4s0QKn5OFOK0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQToUKuwz2Jb8fUUXg/iPHi2LSK/KgXrTbaXbMQx6mV2AQjd8nqsJ7lRGa/DOBaO1
	 vKxB1QjAdiyEn/9lBro9wqp49GEobRgmTrk6H18r7dGQnUw6xb5+wE5V2VxNnzcwjv
	 OOqfIV0Flp77+wu60/UScGJrVh8wGVtO4GTM4dRg=
Date: Mon, 16 Sep 2024 00:41:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linuszeng@tencent.com, linux-kernel@vger.kernel.org, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 yosryahmed@google.com
Subject: Re: [PATCH V2] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Message-Id: <20240916004134.0ef2f50862b59079e1ac2928@linux-foundation.org>
In-Reply-To: <20240913084453.3605621-1-jingxiangzeng.cas@gmail.com>
References: <Jingxiang Zeng <linuszeng@tencent.com>
	<20240913084453.3605621-1-jingxiangzeng.cas@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 16:44:53 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmail.com> wrote:

> From: Jingxiang Zeng <linuszeng@tencent.com>
> 
> In proactive memory reclamation scenarios, it is necessary to estimate the
> pswpin and pswpout metrics of the cgroup to determine whether to continue
> reclaiming anonymous pages in the current batch.  This patch will collect
> these metrics and expose them.
> 

Please explain the differences between v1 and v2:

--- a/mm/memcontrol-v1.c~mm-memcontrol-add-per-memcg-pgpgin-pswpin-counter-v2
+++ a/mm/memcontrol-v1.c
@@ -2729,8 +2729,6 @@ static const char *const memcg1_stat_nam
 static const unsigned int memcg1_events[] = {
 	PGPGIN,
 	PGPGOUT,
-	PSWPIN,
-	PSWPOUT,
 	PGFAULT,
 	PGMAJFAULT,
 };
_


