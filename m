Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4D465360
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbhLAQyN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbhLAQyM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 11:54:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCDFC061748;
        Wed,  1 Dec 2021 08:50:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s137so24254367pgs.5;
        Wed, 01 Dec 2021 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MRSYNLjvSzUUD2xStcS4K0DD5X/I++O60gfhBgUbT1A=;
        b=qD/FVYfVYxmqsU9ppUga0DOisU5misR0u9i2eWCAlmghTQhk2rqoOHFkDMQAVEB5lr
         agBx4fpPF7aHLeF7MxHf/bDvg99DY+6dIugyiOBecjhKRs/ikXPhTZ8ZopDe8vDuHGty
         GDlC+FF6m3p44aef2NDAw2vhjotCIXWmjIWqK4n3Kh66nBFEYQ4fuR+ddkFku29Yw1vH
         0D10wjaXiq155B8cUVi9WVyOjZU9of5qErlotVhwBmvZ1AQ2sZCAxNhimazk28IUvBCd
         MsqbWrBwmOtyJCjwEFRfcV8u92k53umoHak17/mkA4E0CzHB4RMtzvZ+psbSxsOKDW3o
         ruJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MRSYNLjvSzUUD2xStcS4K0DD5X/I++O60gfhBgUbT1A=;
        b=gU/D8N6sPsdA5JvgCcLCvtr9uxE+DedZ4EJgcOoaTUgsRHA+cZsl5PgYteNA2gZHsk
         cVypR639OrZ5SjBfZ/fwQcAb+XyaUf6RZvohAz92WvaLZWc0RyIYUGYx3GZzuNFm9L56
         ayWBhKCUNRMEP5d+z8yRXFlJRwnp/jiX7MdyjJE6r628LxsmrjBFW5INXV6O0haw/aZh
         XcTNIJtmB/OovPOk6yP4JO9lMdTJXtcvxtGQxk2RofHXDfVoC4d6XaqblRQxRUTNcJGf
         8NHcTg3Sm2xvGOqobF1bwffrnVPzgGmKqiKfh3fG5tj5jUHZILOgqqS1QSeyILVWp64p
         aFAg==
X-Gm-Message-State: AOAM533o/fONvfdD4rif2QKtKBGOWMqZecck2lv8XjU+OdQzF+zjVJIu
        KntTqejq4iJqSuo8EH4qHHk=
X-Google-Smtp-Source: ABdhPJwdwieEulaakBV/E1et9FlVwwagtjS2+kVwrJ4Hb3ODRqR/XbzNr9B38dUprfR6U4/cfjxZ6A==
X-Received: by 2002:a65:408c:: with SMTP id t12mr5386528pgp.262.1638377449923;
        Wed, 01 Dec 2021 08:50:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m18sm355740pfk.68.2021.12.01.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:50:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 06:50:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix a typo in comment
Message-ID: <Yaen6KWQyhBAbsks@slm.duckdns.org>
References: <20211201011736.10988-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201011736.10988-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 01, 2021 at 01:17:36AM +0000, Wei Yang wrote:
> In commit 8699b7762a62 ("cgroup: s/child_subsys_mask/subtree_ss_mask/"),
> we rename child_subsys_mask to subtree_ss_mask. While it missed to
> rename this in comment.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied to cgroup/for-5.17.

Thanks.

-- 
tejun
