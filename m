Return-Path: <cgroups+bounces-5734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8741E9DFEF6
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFC281DF2
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50631FBE9B;
	Mon,  2 Dec 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GskGg8jB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730311D5CC6;
	Mon,  2 Dec 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135439; cv=none; b=R64X5b8XjS0CNoDyHPzDfBvAk1ssRc2yl80o/0LG+V1eDqwiU91qW6xWa5xOPdFtNnBd7R4zW2BOutoDScJ/n6xacdh/hkYQ4k5W5xF8Ep0jMiPfm82DWUarfvdIAXh5iTIPz4J8tC2WbX+LWL5kukbq9iHJi62ef/7at2pmXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135439; c=relaxed/simple;
	bh=6CVCXlJ3E/3p2qq23sZZ+/RQc1ErivQ1dc6y5JusCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm+VUA9wdOeRi2doXApMcuUlwMbry7FEGNPJ1yKFuSH+ph3V9hsjETMyhnf+tXoFS2pEQPK60lrxPH3WryJARfU4qfsbQnx2J0iqxygDViKuXB0crOuKxXGpeBIw57c7XR9eePJRneFMFW+voa24v9/HDLEeD1GlXWk7d8/e/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GskGg8jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B1FC4CED1;
	Mon,  2 Dec 2024 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733135438;
	bh=6CVCXlJ3E/3p2qq23sZZ+/RQc1ErivQ1dc6y5JusCZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GskGg8jBYf8zuuYY6ZW9fEW2e26MGr72t5aBaYZfeaWMmSKunfwn4/gcVTAZu8nID
	 63wI6NdivioSIdyopfkpaca2HU9WSt1UIIcdugZYau/jxCU+kbS3/ZRkCuJ5phlXik
	 HiNlm7TzX9gxel/G7kmfqJcKRnKbx/d1npUiqIF8=
Date: Mon, 2 Dec 2024 11:30:35 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"shivani.agarwal@broadcom.com" <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU
 safe
Message-ID: <2024120222-legwarmer-attach-896b@gregkh>
References: <2024120235-path-hangover-4717@gregkh>
 <20241202101102.91106-1-siddh.raman.pant@oracle.com>
 <2024120257-icky-audio-cf30@gregkh>
 <9953011d972d0ec2f38792e985aac55f2e4fda2e.camel@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9953011d972d0ec2f38792e985aac55f2e4fda2e.camel@oracle.com>

On Mon, Dec 02, 2024 at 10:26:54AM +0000, Siddh Raman Pant wrote:
> On Mon, Dec 02 2024 at 15:47:00 +0530, Greg Kroah-Hartman wrote:
> > On Mon, Dec 02, 2024 at 03:41:01PM +0530, Siddh Raman Pant wrote:
> > > From: Yafang Shao <laoar.shao@gmail.com>
> > > 
> > > commit d23b5c577715892c87533b13923306acc6243f93 upstream.
> > > 
> > > At present, when we perform operations on the cgroup root_list, we must
> > > hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
> > > we can make operations on this list RCU-safe, eliminating the need to hold
> > > the cgroup_mutex during traversal. Modifications to the list only occur in
> > > the cgroup root setup and destroy paths, which should be infrequent in a
> > > production environment. In contrast, traversal may occur frequently.
> > > Therefore, making it RCU-safe would be beneficial.
> > > 
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > > [fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
> > >  ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
> > >  codes")]
> > > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > > [Shivani: Modified to apply on v5.4.y]
> > > Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
> > > Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> > 
> > I'm confused.  You do know what signed-off-by means, right?  When
> > sending a patch on, you MUST sign off on it.
> 
> Even if I'm just *forwarding* the patch already posted on the mailing
> list?

Yes.


