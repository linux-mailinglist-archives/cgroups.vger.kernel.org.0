Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4340E962
	for <lists+cgroups@lfdr.de>; Thu, 16 Sep 2021 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbhIPRxs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 13:53:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52544 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350618AbhIPRsz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 13:48:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4544C2230A;
        Thu, 16 Sep 2021 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631814453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UXGxl36cCRWagHQx1D/4h9BCgAVpOE3Af+7fYOJUV0=;
        b=dLDaSykl5mJR7jcwRnUhxcauNzcBfc2gCtJt0X6VjDaaQPGiRZ6kqREm42HSHFP7BjyPBz
        gZBqtJs2KSomO0SiqC7mfpXTbuuui65pkm1+BsbDHWMuPiFQdS+1GL4W0XdPPqfsdZjYah
        vcqv3ZcEYYJkkff26vT71jIz3uVG/g4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2386F13D5A;
        Thu, 16 Sep 2021 17:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X14PCDWDQ2HtbQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 16 Sep 2021 17:47:33 +0000
Date:   Thu, 16 Sep 2021 19:47:31 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] misc_cgroup: introduce misc.events to count
 failures
Message-ID: <20210916174731.GB9090@blackbody.suse.cz>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 15, 2021 at 10:18:49AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Introduce misc.events to make it easier for us to understand
> the pressure of resources. Currently only the 'max' event is
> implemented, which indicates the times the resource is about
> to exceeds the max limit.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
> 
> v3: remove misc.events.local.
> v2: remove cgroup v1 files.
> 
>  include/linux/misc_cgroup.h |  5 +++++
>  kernel/cgroup/misc.c        | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

LGTM,
Reviewed-by: Michal Koutný <mkoutny@suse.com>
