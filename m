Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB5543E61
	for <lists+cgroups@lfdr.de>; Wed,  8 Jun 2022 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiFHVND (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiFHVM7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 17:12:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668B403614;
        Wed,  8 Jun 2022 14:12:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB52921CBD;
        Wed,  8 Jun 2022 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654722775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvLTeRgE922dttN+/SnWY6He1Q8u4Sfu7cqwMi2p5dQ=;
        b=aCK4ctriVdhI1i3ubrX52jvQCh+DlkWCXQwz5PScudBWPXCHGxJrvto5HQYoCNJJdY83dW
        DUTyiUUKa36htw8fg4sJdvRBZx9IwaySmfPEWkDsVBxynKg7tKEFOp1PcNVkXw8gLkzhY3
        4QWesCmAvxZAF3XCs+b/cwVycwLiKYA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 973B413A15;
        Wed,  8 Jun 2022 21:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F3R+I9cQoWLSCgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Jun 2022 21:12:55 +0000
Date:   Wed, 8 Jun 2022 23:12:53 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YqEQ1cudjZmUU7rs@blackbook>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
 <20220608165732.GB19399@blackbody.suse.cz>
 <506eaa3d-be84-c51e-3252-2979847054fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506eaa3d-be84-c51e-3252-2979847054fe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 08, 2022 at 02:16:45PM -0400, Waiman Long <longman@redhat.com> wrote:
> I have thought about that. It can be done as a follow-up patch to add a
> sentinel version into llist and use that instead. Of course, I can also
> update this patchset to include that.

Nothing against the current form, really just an idea for a followup or
prequel.

> Your change may not be enough since there could be update after the flush
> which will pin the blkg and hence blkcg.

Wouldn't that mean submitting a bio from offlined blkcg?
blkg_tryget_closest() should prevent that.

> I guess one possible solution may be to abandon the llist and revert
> back to list iteration when offline. I need to think a bit more about
> that.


> > Maybe bundle the lhead list maintenace with cgroup_rstat_updated() under
> > cgroup_subsys_on_dfl()? The stats can be read on v1 anyway.
> 
> I don't quite understand here. The change is not specific to v1 or v2. What
> do you mean by the stat is readable on v1?

Apologies, the critical "not" fell out. ...can not be read on v1... IOW,
the rstat data are only kept when attached to v2 hierarchy, so the list
of active devices needn't be maintained on v1.


Michal

