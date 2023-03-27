Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C16CB247
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 01:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC0XYy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Mar 2023 19:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC0XYy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Mar 2023 19:24:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251AFB3;
        Mon, 27 Mar 2023 16:24:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B26B51FD7B;
        Mon, 27 Mar 2023 23:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679959491;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WdlRcu20z+c7BKlEbocvqiEmoAKTJAqHgdWdlNpOixc=;
        b=zqEYwHVYk/1fekJ/HfRUW6geAiD0HQfgg52m7TfK+G+8OrzgnjABDvWweuIvPB3HIwq5sY
        cGO343iBWZAsAFJMItu8X286rPBFSoMJcSW/BfYxJi7AZJTGtoKE3B19g2Mmz6hjxaVoMo
        IZNCfEwjbZWTLPIy9HPuRi7zufKKpoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679959491;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WdlRcu20z+c7BKlEbocvqiEmoAKTJAqHgdWdlNpOixc=;
        b=K4g5C3QIXiicnrji11RJBHdEEg9C0358ty8j0k5lOA3D2CSdbOmpn+TgIo78Uwb6+4+1xr
        DQ9aFhIMvev9AgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7476C13482;
        Mon, 27 Mar 2023 23:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VaNrG8MlImTTZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Mar 2023 23:24:51 +0000
Date:   Tue, 28 Mar 2023 01:18:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: move bio cgroup punting into btrfs
Message-ID: <20230327231837.GK10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230327004954.728797-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327004954.728797-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 27, 2023 at 09:49:46AM +0900, Christoph Hellwig wrote:
> Hi all,
> 
> the current code to offload bio submission into a cgroup-specific helper
> thread when sent from the btrfs internal helper threads is a bit ugly.
> 
> This series moves it into btrfs with minimal interference in the core
> code.

I can't speak for the cgroup side, but as btrfs is the only user of the
REQ_CGROUP_PUNT flag pushing it down to the IO submission path makes
sense. Code looks ok, it's a direct conversion.

When the mm/block changes get an Ack I can put it to btrfs for-next.
