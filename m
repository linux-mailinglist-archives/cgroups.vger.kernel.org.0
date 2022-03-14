Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B341E4D8A1A
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiCNQqQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbiCNQp5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 12:45:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6B201AF
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 09:43:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1F02210F9;
        Mon, 14 Mar 2022 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647276214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8aU7ATJhIHHpbiq1kzf5ExUEOuGSR5q8FMA3efJl9M=;
        b=UEr/ewUMeqbiMGFJRQ4009Df5u0krJ3RVo5m9R5yvzdo/MnFsuOSsUDcnHMnjZ/HSubxAH
        YP5vU5U4XDnG5CSdufFH4QcBxVNUHYTbY+v99/hd2sFMb+XpiylFvDmkHaveyfRKiKqByY
        sFc4fxtbqUoUU46itK8l6myhdeixj5s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E14FA13B39;
        Mon, 14 Mar 2022 16:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NehqNrZwL2IrNgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 14 Mar 2022 16:43:34 +0000
Date:   Mon, 14 Mar 2022 17:43:33 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: Split process across multiple schedulers?
Message-ID: <20220314164332.GA20424@blackbody.suse.cz>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Mon, Mar 14, 2022 at 03:19:56PM +0000, Olsson John <john.olsson@saabgroup.com> wrote:
> I have tried reading the documentation for CGroups V1 and V2 and it
> seems that there is one usecase that we are interested in that *is*
> supported by CGroups V1 but not by CGroups V2.

Are you missing CONFIG_RT_GROUP_SCHED and v1 cpu controller's
cpu.rt_{runtime,period}_us? (Just asking, you didn't mention this
explicitly in your e-mail but it sounds so and it's a thing that's
indeed missing in v2.)

> My understanding of CGroups V1 is that it is possible to have one
> scheduler associated  there are use cases where you might want to have
> one kind of scheduler for the VMM process (for instance CFS) and
> another scheduler for the virtual core threads (for instance FIFO).

sched_setscheduler(2) applies to threads regardless of cgroup
membership, there's no change between v1 and v2.

(Without CONFIG_RT_GROUP_SCHED all RT threads are effectively in the
root cgroup.)

> My conclusion after reading the documentation for CGroups V2 is that
> the above scenario is no longer possible to do. Or have I
> misunderstood something here?

You may need to enable threaded mode on v2 (see cgroup.type) to
manipulate with individual threads across cgroups. (E.g. if you want to
use cpuset controller to pin/restrict individual threads.)

Regards,
Michal
