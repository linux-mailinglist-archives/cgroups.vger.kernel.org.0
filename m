Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEB179D4F
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 02:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgCEB3m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 20:29:42 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57235 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgCEB3m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 20:29:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 355FA21C46;
        Wed,  4 Mar 2020 20:29:41 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Wed, 04 Mar 2020 20:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=T9JaF4sGM4j6APTDjyVGLfdoZyWnOlU
        PZp/Hqn+ZrA8=; b=y1apH15KPMNh2yNs/t38MuiG9vqULi0LjWZ8Ury1oTimMXN
        hX5b54APNeUiFQdR8N5YAT9tHIxCn7eVzuDYjh1yo586pzuq4Vs6XSlQphYATqlJ
        akFK/WIxGNNIxnGCwCOnVISQxbl/7KRPhFH14XD9tsDb5bXUfJR6TsRTVlq5rgyc
        jd9NYf5Vjmq+S5lq7I3SYqXfE+E86CqnYEUE1QOcvAcJB2CHocXxi0kpzjHllyEV
        x+YHqeFvrCKv3jDYaTjxjxcSqpDUg9nibza8Bt0vpm+PqrzF0nhdojGD9y32SgE8
        GtaeSukZXFag/JTYElWPcTXYwkgGsXT7xq7HgDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=T9JaF4
        sGM4j6APTDjyVGLfdoZyWnOlUPZp/Hqn+ZrA8=; b=ZYnJu/Wq3I5F4OKn/ROuu4
        sZ2gB/Y+V8sfwnXZ0RaE3s/AJhQLc0THe9jvAlNiTOYL4jnCTtAKN9ZW/wTtezWR
        KUGPnSaAOAttEvL0iFN7JAe3JTLygMONl/Wcov0s92NmjAf2BZN+fFy3PAg9HJSR
        zmHVvxkXpwTuKuDFfnfJkbqpxMK4Anb85YYKozLeOplZt0n5/9jh2SDpAJBl1eOI
        eApMgsTWcQTlUOoarKQvsaizLwYqJ5AKFGLxt6AwiRyVRy6W0MSz+j5Ms58UiU41
        75Ax1rxAbx4xz8uj6Be8UOkIA1QPnhUvxP8eeYaHEYOn+NDxlVpauBBtkEfTKH9g
        ==
X-ME-Sender: <xms:A1ZgXoX3rnPnO1tBWcGFHhuAmJY_qcuarAeJ5qkZQdocccim2YNfZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludejmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuffhomhgrihhnpehlfihnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurd
    ighiii
X-ME-Proxy: <xmx:A1ZgXly3OSpLGX2_XVD5Muw4qf7wdXKpyPUcbTPWGwxM4HccEXEDyA>
    <xmx:A1ZgXgrtDEPpGuKiQiw-ggCcVRxGjDcxsgQ8qV51jmtsh1BNjauFFg>
    <xmx:A1ZgXtHrF2pkBFlHs0eXneWgowE9Q5hz1qQFo9YMXtBiHsCWARbgDA>
    <xmx:BVZgXiypN1i-M2wBd7mw9zKy5w9oupbblJyg7T1KtRTuMcDxp6kcBg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 308E214C010C; Wed,  4 Mar 2020 20:29:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-988-g326a76f-fmstable-20200305v1
Mime-Version: 1.0
Message-Id: <5e0c59bd-ad59-4999-9a41-4239b96b1fc9@www.fastmail.com>
In-Reply-To: <20200304171051.GK189690@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
 <20200304163044.GF189690@mtj.thefacebook.com>
 <20200304100231.2213a982@lwn.net>
 <20200304171051.GK189690@mtj.thefacebook.com>
Date:   Wed, 04 Mar 2020 17:29:18 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Tejun Heo" <tj@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>
Cc:     "Benjamin Berg" <benjamin@sipsolutions.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        "Johannes Weiner" <hannes@cmpxchg.org>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 4, 2020, at 9:10 AM, Tejun Heo wrote:
> On Wed, Mar 04, 2020 at 10:02:31AM -0700, Jonathan Corbet wrote:
> > On Wed, 4 Mar 2020 11:30:44 -0500
> > Tejun Heo <tj@kernel.org> wrote:
> > 
> > > > (In a realistic scenario I expect to have swap and then reserving maybe
> > > > a few hundred MiB; DAMON might help with finding good values.)  
> > > 
> > > What's DAMON?
> > 
> > 	https://lwn.net/Articles/812707/
> 
> Ah, thanks a lot for the link. That's neat. For determining workload
> size, we're using senpai:
> 
>  https://github.com/facebookincubator/senpai
[...]

For reference, senpai is currently deployed as an oomd plugin:
https://github.com/facebookincubator/oomd/blob/master/src/oomd/plugins/Senpai.cpp .

The python version might be a bit out of date -- Johannes probably knows.
