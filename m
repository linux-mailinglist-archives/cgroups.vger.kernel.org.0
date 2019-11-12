Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9825F9527
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLQI0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 11:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfKLQI0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 Nov 2019 11:08:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F67214E0;
        Tue, 12 Nov 2019 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573574905;
        bh=F7Oqc0NxmF2ZrnvLzaUQ+E39TJo13Hl0CGan0+wgTp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzFTos7eruaTOsKE5+72Q7SXyMSuITi7cu2SZ4CfLIj4ijcK4cj6dbrsSOAppb/cb
         Zq6QaiB1bFPqt14BKIn2ojvLBPV7IT19ic/k0oN5mpbLVP1IYHWTGvVoYWVJgh1p+7
         GR2k3dw1z4y0xR5ET1oNIKJXtq1FUREH4o109kgI=
Date:   Tue, 12 Nov 2019 17:08:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCHSET cgroup/for-5.5] kernfs,cgroup: support 64bit inos and
 unify cgroup IDs
Message-ID: <20191112160820.GA1685314@kroah.com>
References: <20191104235944.3470866-1-tj@kernel.org>
 <20191112155114.GF4163745@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112155114.GF4163745@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 07:51:14AM -0800, Tejun Heo wrote:
> Hello, Greg.
> 
> A gentle ping.  I can route these through cgroup/for-5.5 if you're
> okay with the patch series.

Oops, let me go review...
