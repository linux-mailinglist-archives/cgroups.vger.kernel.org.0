Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB8543F04
	for <lists+cgroups@lfdr.de>; Thu,  9 Jun 2022 00:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiFHWOV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 18:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFHWOT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 18:14:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A5B60D0;
        Wed,  8 Jun 2022 15:14:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1FB61FD42;
        Wed,  8 Jun 2022 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654726456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYRBaqQ5xfDUzDMhvL/gENcLA6nTCJt7le5LzsPSniY=;
        b=E8LMadkm3oV0PagrJYsbb9CJD02ZCJKLnfI+SV3wWkspNytEU+mEt9e0Xfr8NDYsFmKi1k
        D0IIgWsaHyT4g/EnsJ4cTeMnDvFPy7xV3TgWjpVp9blE6TuD1CCF4okKm/Q7cb2YPuJpLw
        RtRxhJxH2wDE05ScRVzlUNeWWaswivo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C2B113AD9;
        Wed,  8 Jun 2022 22:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lzm/JDgfoWINHQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Jun 2022 22:14:16 +0000
Date:   Thu, 9 Jun 2022 00:14:14 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YqEfNgUc8jxlAq8D@blackbook>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
 <20220608165732.GB19399@blackbody.suse.cz>
 <506eaa3d-be84-c51e-3252-2979847054fe@redhat.com>
 <YqEQ1cudjZmUU7rs@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqEQ1cudjZmUU7rs@blackbook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 08, 2022 at 11:12:55PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> Wouldn't that mean submitting a bio from offlined blkcg?
> blkg_tryget_closest() should prevent that.

Self-correction -- no, forgot blkg_tryget_closest() gets any non-zero
reference, not just a live one (percpu_ref_tryget_live()), furthermore,
I can see that offlined blkcg may still issue writeback bios for
instance.

> > I guess one possible solution may be to abandon the llist and revert
> > back to list iteration when offline. I need to think a bit more about
> > that.

Since blkcg stats are only used for io.stat of an online blkcg, the
update may be skipped on an offlined blkcg. (Which of course breaks when
something starts to depend on the stats of an offlined blkcg.)

Michal
