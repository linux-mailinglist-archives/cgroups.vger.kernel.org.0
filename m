Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1296E47E6B9
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbhLWRNu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Dec 2021 12:13:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53342 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244347AbhLWRNu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Dec 2021 12:13:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F15A8210FE;
        Thu, 23 Dec 2021 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640279628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TK8w/l2QmkKbweJf4VP5hkqJcVEfLR6+7DArEF8svg0=;
        b=N3/Mg4U+xanWLS7bAaYDZP3g6btzRSuYvsvFl8fzz3i/KoD0mzhP2WkozLnYEXg7pAYEcL
        7aZqzXk5T/hOrNJpK83n2KFLjdJYNcdM6OyxH6/i40b0Rrmcwyo8mJ1Sed6xjKpip4/MmU
        30TjoOc1SpPAloZxkLpf6Q8a8FnMLa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640279628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TK8w/l2QmkKbweJf4VP5hkqJcVEfLR6+7DArEF8svg0=;
        b=fZsVIT/8nYiFKohB3PYI+Tz1zhjd13tVgKSwUm+zfPngwa8hyJelVLscYzOYaxhslRz9Z4
        HQOjiTluRe2hvyAQ==
Received: from quack2.suse.cz (jack.udp.ovpn1.nue.suse.de [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id DC225A3B81;
        Thu, 23 Dec 2021 17:13:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA0051E1328; Thu, 23 Dec 2021 18:13:45 +0100 (CET)
Date:   Thu, 23 Dec 2021 18:13:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogt@suse.de, cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <20211223171345.GE19129@quack2.suse.cz>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <20211129171115.GC29512@quack2.suse.cz>
 <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
 <20211222152103.GF685@quack2.suse.cz>
 <d770663a-911c-c9c1-1185-558634f4c738@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d770663a-911c-c9c1-1185-558634f4c738@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-12-21 09:02:55, yukuai (C) wrote:
> 在 2021/12/22 23:21, Jan Kara 写道:
> > On Thu 09-12-21 10:23:33, yukuai (C) wrote:
> > > We confirmed this by our reproducer through a simple patch:
> > > stop merging bfq_queues if their parents are different.
> > 
> > Can you please share your reproducer? I have prepared some patches which
> > I'd like to verify before posting... Thanks!
> 
> Hi,
> 
> Here is the reproducer, usually the problem will come up within an
> hour.

Thanks! For some reason the reproducer does not trigger the KASAN warning
for me (with or without my patches). But anyway, I'll post my fixes and
we'll see what do people think, also I'd be grateful if you can test them
in your environment. Thanks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
