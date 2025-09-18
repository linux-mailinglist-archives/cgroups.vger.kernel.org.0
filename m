Return-Path: <cgroups+bounces-10261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812DEB85BB5
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5821666B5
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B921171B;
	Thu, 18 Sep 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMUX8YA+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5530CDAC;
	Thu, 18 Sep 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210298; cv=none; b=XeUQeywCuhIn6EFEZC/McpUJaMhqrLoYpqmJo9CCpeWPcqgJL0q2VC5BLXc0r8s4LLIBCn1E7YeibGFQyQaDPAVCaHhKrCURU7lBpIuSehTeHDdgF4gduqteobziuWlCzTVGG4Y80zgdaYxGaAZqvoOoEKq626EdisdSkWpd8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210298; c=relaxed/simple;
	bh=bvv+z9so6Iw7qlIsaoYjvpqwoxpXh+uc5BlqRON5JAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0SDcchzbeykL5aK0J1GlW4M+6F7tzNfvVRupS3qFOiJKVDgkDkY6kW5kwyPtKipo4e/1ap1byzMHzp7A0801C+GW1RM+G4RNeHjxSv/e7q5IhsNCHYqOnw0MRnls0UytMrPvZ7LP46PXk1Yt3XSoXd94rIWniBzVK+7LMv1O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMUX8YA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B1C4CEEB;
	Thu, 18 Sep 2025 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210297;
	bh=bvv+z9so6Iw7qlIsaoYjvpqwoxpXh+uc5BlqRON5JAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMUX8YA+w5J1k4SiR7ELmjFQ/Bs1MbKzARlZbm1yVubyVsx5SmuN5PVrUg4/lLUb8
	 mlNQt9/6VWnSnvJDJIXxJHLBCRGPdTr/dW3Juq+0xO80pqA19mYaoXv5xiWOGyWUC0
	 +w0d0VJ11+kuxgcxvWK9e0dmZw8IpypYs2+8teQIHajjRzDO3gvY5Wl2RP1/AmsBXe
	 2GI+yhBELcUUN+9HwR2gQQ5hWDBvc1RoIveJ4z+AwYTyK8LPeQnkmnOPEywEDeCyQT
	 ckRzGAOlhmZus0lfI/rUMiCZVYawPWyz3NIp8VKjMGroaXJWXBhMPzDPGElhDMUBx7
	 S/3pMP2htU5YA==
Date: Thu, 18 Sep 2025 05:44:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <aMwo-IW35bsdc1BM@slm.duckdns.org>
References: <20250918074048.18563-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918074048.18563-2-bagasdotme@gmail.com>

Hello,

On Thu, Sep 18, 2025 at 02:40:49PM +0700, Bagas Sanjaya wrote:
> cgroup v2 docs is a lengthy single docs, as compared to cgroup v1 which
> is split into several reST files. Meanwhile, its manually-arranged table
> of contents can get (and indeed) out-of-sync with actual contents when
> new sections forget to be added to it.
> 
> Replace it with automatically-generated table of contents via contents::
> directive.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

I don't think I'm going to apply this. Sure, it can get out of sync but I'd
rather have TOC which sometimes is a bit out of sync than none at all.

Thanks.

-- 
tejun

