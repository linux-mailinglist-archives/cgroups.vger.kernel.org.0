Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782A540FE0A
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhIQQmx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 12:42:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbhIQQmw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 12:42:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D08C822114;
        Fri, 17 Sep 2021 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631896884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwaqMdctCtkMhcrq7X60eNjofQ9lWwgd/iusn9WBbEA=;
        b=PbJoSdNsPCqlSw0D7Sh3n5rTllj5/wyXxBazr+qWOZMoQQlBybauEnqI8Gm8V/sIq94w/D
        Lcp7rqPruJvO6LS5nLeXi8LvYc/Ap59lR/G+GBU1X9xN+Ig4Ea3rZYKd4MMetz4fi95PKC
        R0JnTVpP0tBXTFhSmBy091qmE2UTVcI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B994213B7E;
        Fri, 17 Sep 2021 16:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yOPKLDTFRGENWAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Sep 2021 16:41:24 +0000
Date:   Fri, 17 Sep 2021 18:41:23 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com, tj@kernel.org
Subject: Re: KCSAN: data-race in cgroup_rstat_flush_locked /
 cgroup_rstat_updated
Message-ID: <20210917164123.GA13346@blackbody.suse.cz>
References: <CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Hao.

On Thu, Sep 16, 2021 at 09:53:55PM +0800, Hao Sun <sunhao.th@gmail.com> wrote:
> KCSAN reported the following data race during the kernel booting when
> using Healer to fuzz the latest Linux kernel.
> [...]
>  cgroup_rstat_cpu_pop_updated kernel/cgroup/rstat.c:139 [inline]
>  [...]
>  cgroup_rstat_updated+0x53/0x1b0 kernel/cgroup/rstat.c:38

FWIW, it's a "safe" race between updaters and flushers (possibly
missing the latest update(s)). This is expected as explained in
cgroup_rstat_updated() comment.

Michal
