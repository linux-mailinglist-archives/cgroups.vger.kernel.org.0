Return-Path: <cgroups+bounces-8427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D179ACCCE9
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 20:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911E718932B3
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F45288C3C;
	Tue,  3 Jun 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVkdhqsb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47323BCF0;
	Tue,  3 Jun 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975268; cv=none; b=Vp8UkOfk609rvk8MyZyRisEll/ZXtVLyhjkqSFqVfhKH8AUSZVaPOQAyDgD9OILvYJWndX6BKzCQg2J9+8jG337ute4LYfnYOfscRjloA20QBafP0TFvXZyCd+vFi3ByjUC+EX/PqY+0D8jLQZnoihEC+NKeG6/As3kJGp/YD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975268; c=relaxed/simple;
	bh=2ojqRapvZQ0p/zj56F1HLnrtVP2feRC6AnAIidMhuZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBOLSBHhsIKWiKNNTP98DqSNii4KXUy3bhPe4cirvKpbK/pym118TOq7dAPcF85OuuCZLT4d5bKXyIbrPjH2brRVnJkTmaKW061V4IEGGTcRy3joQS7KEO4vYB0x8hsMGKEhFC6p3mJJt6VNEe759b3RY3Vj9Ut+7MqPC87vG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVkdhqsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CE2C4CEED;
	Tue,  3 Jun 2025 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975266;
	bh=2ojqRapvZQ0p/zj56F1HLnrtVP2feRC6AnAIidMhuZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVkdhqsbIlkhwIV5CHtX8HaDVTrcwvoY0ZaT0Es5gepPuEL7ZYkwAxIBX3iIsY0Xf
	 wsrYRzWIF2BtJLxes/nh9/UtiBTablWOLf0paOZLNLcIFM4/waL+cxRz6iTmF8LeUI
	 5YQTLByB4Wp/+tctBSP9AbBaS1ErKG+CGNYNm+idtnbjPC/uX4hzVGA99E/evvklez
	 kCaI6Lcs+K+PsfxuoIosAMm5Q2mi6IMyK8X6z/Cb3acjiMXuhEil5HCY6zpJ+1dYJl
	 g+iYZHlgJCQh4RLkVOj7LdRiL9B8UfHo2jsffzcp8fbwUtta+nvKsR+eNMlE+OiseQ
	 cwy8/R3lun31Q==
Date: Tue, 3 Jun 2025 08:27:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] cgroup: Drop sock_cgroup_classid() dummy implementation
Message-ID: <aD8-oZ-Rl8AnXTi_@slm.duckdns.org>
References: <20250603154528.807949-1-mkoutny@suse.com>
 <aD87xm9H_wiQK_S2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aD87xm9H_wiQK_S2@slm.duckdns.org>

On Tue, Jun 03, 2025 at 08:15:34AM -1000, Tejun Heo wrote:
> On Tue, Jun 03, 2025 at 05:45:27PM +0200, Michal Koutný wrote:
> > The semantic of returning 0 is unclear when !CONFIG_CGROUP_NET_CLASSID.
> > Since there are no callers of sock_cgroup_classid() with that config
> > anymore we can undefine the helper at all and enforce all (future)
> > callers to handle cases when !CONFIG_CGROUP_NET_CLASSID.
> > 
> > Signed-off-by: Michal Koutný <mkoutny@suse.com>
> > Link: https://lore.kernel.org/r/Z_52r_v9-3JUzDT7@calendula/
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> Applied to cgroup/for-6.16-fixes.

Make that for-6.17.

Thanks.

-- 
tejun

