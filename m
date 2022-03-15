Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF704DA156
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiCORet (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Mar 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiCORes (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 13:34:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2795F22529
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 10:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E851210ED;
        Tue, 15 Mar 2022 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647365612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SCnDXkSTk7b/B3VCA90vLf8UjLiVvHK4RLBoX9cBfI=;
        b=N6uWbM2pvpNvTSV+X9Jc71F4clakLdT6Y46VqAJMCwxztGuq+nFvlfrZMsTW63LSan0ydQ
        1pkfaUpBhmqBGL9hka/eENM1TZQrClRjQ2k/AWZo7Wm9Sx7wLrNHak5YMGgWq9YhkfKsUY
        x3riBzhht+yXsB8jjTXrJqk0dTqZxAA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F0FE13B66;
        Tue, 15 Mar 2022 17:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7J3GEuzNMGK2WgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Mar 2022 17:33:32 +0000
Date:   Tue, 15 Mar 2022 18:33:31 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Split process across multiple schedulers?
Message-ID: <20220315173329.GB3780@blackbody.suse.cz>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <20220314164332.GA20424@blackbody.suse.cz>
 <bf2ea0888a9e45d3aafe412f0094cf86@saabgroup.com>
 <20220315103553.GA3780@blackbody.suse.cz>
 <84e5b8652edd47d29597d499f29753d6@saabgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e5b8652edd47d29597d499f29753d6@saabgroup.com>
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

On Tue, Mar 15, 2022 at 03:49:52PM +0000, Olsson John <john.olsson@saabgroup.com> wrote:
> As you might have already surmised it was a placeholder example to
> give the general idea. I think it is time to add some more details. :)

Thanks for sharing the additional description.

> Assume that you have an embedded system running some kind of software
> with real time like properties. You want to develop and debug your
> software locally on your high-end machine since it is much more
> convenient. Alas the software runs way too fast due to the difference
> in performance so you can't detect overruns etc.

There are certainly more knowledgeable people than me to help with
debugging such environments.

> One way of implementing this kind of scheduler would be to create a
> fork of the FIFO scheduler that have this behavior.

I think you've complete info now how threads are handled with cgroups.

Good luck with the fork :-)


Michal
