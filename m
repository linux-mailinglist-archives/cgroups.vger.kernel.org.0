Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0340F3D0
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhIQIKu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 04:10:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49824 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbhIQIKk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 04:10:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51D3F1FD5D;
        Fri, 17 Sep 2021 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631866157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDJr73yVgkekvJkt9rshETzgKC3pw7Vz16Ry4YYZbBs=;
        b=ZPp0s+c+kU2WIdmH5VZIdC9hGdFR4TJoACC7/rZZPsJXF9Hr309Yto92B1EsTJX6r9fJ5C
        G9t1az9JzcVWXFR0nWQKYbRz0xpNDSmYFe2WuGzhI2Fjoyh0DC6EpWPPltSDeRFegnDC4q
        SjpweXDINhG1aTsH/P5mflYoPm7nCPs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 322E113A86;
        Fri, 17 Sep 2021 08:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HPWFCy1NRGFxKwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Sep 2021 08:09:17 +0000
Date:   Fri, 17 Sep 2021 10:09:15 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <20210917080915.GB3827@blackbody.suse.cz>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
 <a960cd793f649bd944127fe5e5e3f4d8bb9040a4.1631671936.git.brookxu@tencent.com>
 <20210916175711.GA12643@blackbody.suse.cz>
 <eece1309-4c1e-909a-22ea-3db31ad7a1da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eece1309-4c1e-909a-22ea-3db31ad7a1da@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 17, 2021 at 09:56:26AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> Yeah, maybe we should make it more clearly, What do you think of
> the commit below:
> 
> In scenarios where containers are frequently created and deleted,
> a large number of error logs maybe generated. The logs only show
> which node is about to go over the max limit, not the node which
> resource request failed. As misc.event has provided relevant
> information, maybe we can remove this log.

It is a good reasoning for the change. LGTM.

Michal
