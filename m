Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856684134AA
	for <lists+cgroups@lfdr.de>; Tue, 21 Sep 2021 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhIUNpr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Sep 2021 09:45:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34198 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhIUNpq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Sep 2021 09:45:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36CF31FEE4;
        Tue, 21 Sep 2021 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632231856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoZFjUYonYzhLeSwSFFInp3fJp1MWSimvWrr2M9y5z0=;
        b=fFHRp+PyX8nFEjo6545k/OVEsKq9G7hPqicI15E/whzFTyEOgindG4LI2Ezrd/XHCRCe/f
        t53qH5/+b1pYVozrTj8l5BYE7PyQ9HPvf+OOp1MWSf2Ym4nKNLxwGIWo2JHw4RZ33f6CeH
        Fz15o72HVrYvhAeBmFAHiHMG3a8G8h4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1762D13BCD;
        Tue, 21 Sep 2021 13:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q68OBbDhSWFpRwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 21 Sep 2021 13:44:16 +0000
Date:   Tue, 21 Sep 2021 15:44:14 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "yukuai (C)" <yukuai3@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup
 v2
Message-ID: <20210921134414.GE4091@blackbody.suse.cz>
References: <20210909140815.2600858-1-yukuai3@huawei.com>
 <20210917174103.GC13346@blackbody.suse.cz>
 <CACGdZYJiLuh6kED_tdWkYqbHDXc_18m-XJbevp-ri5ansvbtYg@mail.gmail.com>
 <37f8c687-8549-104a-2501-532a0cfc9a48@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37f8c687-8549-104a-2501-532a0cfc9a48@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 19, 2021 at 06:31:38PM +0800, "yukuai (C)" <yukuai3@huawei.com> wrote:
> Our use case is similair to this, a host can provide several remote
> devices to difierent client. If one client is under high io pressure,
> other client might be affected. Thus we want to limit the overall
> iops/bps from the client.

I see where are you coming from now. (Perhaps I'd suggest
allocating/prioritizing the allowances on the hosting side. If simply
wrapping "everything" into a non-root cgroup is not enough.)


On 2021/09/18 3:58, Khazhy Kumykov wrote:
> (This does also bring up: if this is a useful thing, would it make
> sense to tie to the device, vs. requiring cgroup. We happen to use
> cgroups so that requirement doesn't affect us).

Good point, That's IMO a better idea, it'd be more consistent with other
resources for which there exist global (cgroup independent) kernel
constraints (e.g. threads-max sysctl, mem= cmdline, cpu hotplug) that
double the root cgroup contraint role.

OTOH, this also deepens the precedent of init NS root cgroup being
special (more special than a container's root cgroup).

My .02€,
Michal
