Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111B406A2A
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhIJKeT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 06:34:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51734 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhIJKeT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 06:34:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88BEE20056;
        Fri, 10 Sep 2021 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631269987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuD6HYOFCTA+t/pZ+ukbmTtyDG3QvPABmFJv2yqsIU4=;
        b=mMe6RbfGZXixrP2ucNxm8af8RpQwXsefvWROdXE9QrJXQ1N8d+PdYmk7IX7odV5t47MMYm
        qROWOWAEmimRcB8UkU/UoV/PuBnm8MJFn7T2ZUMfimW7SgwWWuxfHy8Af42BcLwXWTmbH3
        t9PPGInQY8hUuPUIxeudI2/7po/voNQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6915413D29;
        Fri, 10 Sep 2021 10:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4PcyGWM0O2GEFQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 10 Sep 2021 10:33:07 +0000
Date:   Fri, 10 Sep 2021 12:33:06 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>, tj@kernel.org
Cc:     Vipin Sharma <vipinsh@google.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and
 misc_events.local
Message-ID: <20210910103306.GA24156@blackbody.suse.cz>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <20210909143702.GA13761@blackbody.suse.cz>
 <CAHVum0eGN=v1kLqHQg7HBESp8Kg4aGZFNd4XTpxfeyToXPmPVg@mail.gmail.com>
 <8259b666-f3a4-6788-880c-38d679414bcb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8259b666-f3a4-6788-880c-38d679414bcb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 10, 2021 at 01:20:37PM +0800, brookxu <brookxu.cn@gmail.com> wr=
ote:
> Yeah, this is more reasonable. But there is still one question, whether we
> need to be consistent with other cgroup subsystems, events and events.loc=
al
> under v1 should not support hierarchy=EF=BC=9F

My take is that it's acceptable to present the v2-like files in v1 too
for the sake of simplicity since:
- this is not used yet,
- the v1 is less conventional and
- the presence of events.local would cater even to cases with tasks in
  inner nodes.

It'd be good to have Tejun's insight on this too.

Michal
