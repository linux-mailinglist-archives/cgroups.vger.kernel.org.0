Return-Path: <cgroups+bounces-9876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48451B5194C
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD721C2647D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7B32BF44;
	Wed, 10 Sep 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hAWYwKRu"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EFF32A82B;
	Wed, 10 Sep 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514449; cv=none; b=F18IAh5laLg5WPVop09t0Wejf7HYxyD28b6eaeovWNp/3fyow2pzturD6hnFX86hvHoD3e6BFFC8f7xbfuH/URCGvMpVbkt9kWVz0Fn6wPQ4DddC9/IfiozsQsdSqyKIgJytjArEnz53EXtD9hgDLX2wuA//079BHw/nxQ+BqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514449; c=relaxed/simple;
	bh=oMDCWU30HujjZ+8S4IQ5ZfEg0rLfIbXKlzXknq0TBd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qUd0O2QsViUDB6mwsIVKdZThM+aKK+ew+7AfL+UJXpp5FLgGzCsLKrmntXqQfKXEZWBPcGYX2U7qxeXkT1kRsgL+i74M/X0vqJpgPH/opAhCIjpo4Glm6gBi6TCfRzsal79unoc357t8G85nGGzlygVMARcuRPKzvf1C6cm2iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hAWYwKRu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2BE2540AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757514446; bh=RVT0I1HAqlZxGFXP2jet5a+znetQXZ+SBMv+RkKtwp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hAWYwKRu8CfirR6PVT4DNRbLJsJkyHzfzglojDCnbKQBUcUYf/vgQpK071i02TGub
	 IHgZHZQQmdQgwBOkWe2m3BhSN+joePmrfyjsbLRH6/kIekBjH5IRQb6JOd4Rx8J7FU
	 ycDWBMnouFDukmoCzR17hCHg2FoQaHZvUuNKtj5g2GnoLLYHqXZzh0SSena/sN+DXL
	 DP9XOzvZDXTOZnZfCc6y3YhPauqHh3a0Br8+qk6vL5hvpOyG6hCvORp+V8zOmh/dt9
	 EU9mWUNfephv95eB00+AUMe6z39fgSgUq/6Cx46BlFG8H5b1EcU+vTbb42ZWQf/xgP
	 4CakAC0LscFlg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2BE2540AF5;
	Wed, 10 Sep 2025 14:27:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>,
 Tejun
 Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Andrea Righi
 <arighi@nvidia.com>, Johannes Bechberger <me@mostlynerdless.de>, Changwoo
 Min <changwoo@igalia.com>, Shashank Balaji <shashank.mahadasyam@sony.com>,
 Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can
 <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
In-Reply-To: <20250910155021.418ac199@foz.lan>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
 <875xdqtp7m.fsf@trenco.lwn.net> <20250910155021.418ac199@foz.lan>
Date: Wed, 10 Sep 2025 08:27:25 -0600
Message-ID: <87o6ris7qq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Agreed. If you use:
>
>
> 	.. toctree::
> 	   :maxdepth: 1
> 	   :glob:
>
> 	   * 
>
> There won't be the need of manually updating the TOC tree.
>
> That's said, I guess very few documents currently use grub:
> 	$ git grep :glob: Documentation/|wc -l
> 	7
>
> Also, it has some drawbacks, as you can't control anymore the order 
> where the docs will be placed. So, if this is important, you may need
> to do something different, or maybe use things like (untested):

So this is a different level of TOC than what was originally being
discussed ... but now that we're here, I have to say that I am not a fan
of the use of wildcard toctrees in this way.  The index.rst files easily
become unstructured dumping grounds as it is; wildcards just make that
even worse.

IMO, every addition to a toctree should be considered with regard to
position, and the organization of the containing file in general.  But
then, I'm known to be an optimist.

jon

