Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104114121FF
	for <lists+cgroups@lfdr.de>; Mon, 20 Sep 2021 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376307AbhITSLi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Sep 2021 14:11:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347555AbhITSL1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Sep 2021 14:11:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1108121E01;
        Mon, 20 Sep 2021 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632161398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yj+rn7X7blaGJxKz6YARrP61pm4Y5j/vfBu3FSYFlDA=;
        b=qlehDK0CFFKnSnsii0H5002strjfvg/tJ9yr9Tlkpkwdvxv9Np/26+7aQvfmjvZ/f9kgOX
        DplAYbk5REraP/V+Ok0WeqY/SG46eO8MnmcRCksvswS4NoPhRzQ0bLuC6WvsEgRoT8RfSe
        wtlBzJtUDVCcAZBBkbpzKVbVXDL4wMo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E09E713AE9;
        Mon, 20 Sep 2021 18:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vHXFNXXOSGHAcgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 20 Sep 2021 18:09:57 +0000
Date:   Mon, 20 Sep 2021 20:09:56 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com, tj@kernel.org
Subject: Re: KCSAN: data-race in cgroup_rstat_flush_locked /
 cgroup_rstat_updated
Message-ID: <20210920180956.GA15043@blackbody.suse.cz>
References: <CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com>
 <20210917164123.GA13346@blackbody.suse.cz>
 <CACkBjsZnp8Kf26tR3anbcLQNiMJ9=bqYMJ66tKBvXO6tkV3qyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsZnp8Kf26tR3anbcLQNiMJ9=bqYMJ66tKBvXO6tkV3qyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 18, 2021 at 09:27:08AM +0800, Hao Sun <sunhao.th@gmail.com> wrote:
> Would it be better to add a `data_race` macro to the corresponding
> location so that the false report can be disabled?

Something like this

--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -35,7 +35,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
         * instead of NULL, we can tell whether @cgrp is on the list by
         * testing the next pointer for NULL.
         */
-       if (cgroup_rstat_cpu(cgrp, cpu)->updated_next)
+       if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
                return;

        raw_spin_lock_irqsave(cpu_lock, flags);
?

Makes sense to me. Will you send a patch (if this resolves your KCSAN
noise)?

(IIUC, this becase more visible after commit aa48e47e3906 ("memcg:
infrastructure to flush memcg stats") v5.15-rc1 but it was present since
d8ef4b38cb69 ("Revert "cgroup: Add memory barriers to plug
cgroup_rstat_updated() race window"") v5.7.)

> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt#n58
> for more details.

(Interesting, learning...)

Thanks,
Michal
