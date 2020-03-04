Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5B179632
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCDRCc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 12:02:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:45852 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCDRCc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 4 Mar 2020 12:02:32 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 37C6B823;
        Wed,  4 Mar 2020 17:02:32 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:02:31 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
Message-ID: <20200304100231.2213a982@lwn.net>
In-Reply-To: <20200304163044.GF189690@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
        <20200304163044.GF189690@mtj.thefacebook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 4 Mar 2020 11:30:44 -0500
Tejun Heo <tj@kernel.org> wrote:

> > (In a realistic scenario I expect to have swap and then reserving maybe
> > a few hundred MiB; DAMON might help with finding good values.)  
> 
> What's DAMON?

	https://lwn.net/Articles/812707/

jon
