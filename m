Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122D79F4AD
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 00:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjIMWHc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjIMWHb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 18:07:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195919A6
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 15:07:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7423ef3eso2234315ad.3
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694642847; x=1695247647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxDfuaaCOGIkY/J7UCucAcZfBxGD0O7N2E+zpPv/A2A=;
        b=jOHPy3ruaBE5qFzc9ldCHn0VON770hgjGuV8uGeSixVmPSAAx6XwxyvPZ6c8qvm/li
         bsB48BIioFGP5F4W67eldUtaIPc/fYEZADn/8YFBtFgXdVm9AD1W0A7JzBf+choJwFzj
         w9/fi9bS8xWE9HoMFdwluFoKdGgTUC5vDOT8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642847; x=1695247647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxDfuaaCOGIkY/J7UCucAcZfBxGD0O7N2E+zpPv/A2A=;
        b=nQczawlIThePcSRadFvfelkbPssxmq5xJ6DLJdQMK6wmJ+wPsKdFJFoG3GfqL9aEym
         qMLpkEtYPg9Z9VXinj1ik5LiCL3dVuiMmHqU3VPzQtKwxAz8va5lXAOyuPzFoALpMUrx
         WvsgGYGx8H73Qm5JvHOp0u/yuLdF/Krz7y2IgDiap+aDO0QnFDwHWlrktr7GRMvDMzqD
         K6dQaPENmwp6jZgaTUYMWgVQMCdD9HdLo88q08iG2qK3yGqyMV9fU6InK0kyE+cn4qW0
         aD+e2OKmn9EeaFhCgCzfqY39Sk2PM+TYW5doJJ8ySXaRvelHJSPH/qznwUB9++wGKIAw
         Dw4A==
X-Gm-Message-State: AOJu0Ywkz7NDet7kIo+c9x+pzRUKP4yYcA5U7jEvuw9kFRclIS8ldir9
        OileYK16CBBe2HXzl6RwtDOPdw==
X-Google-Smtp-Source: AGHT+IHxaT5/+ccui2vnFiQVAeKtjd2URt+LuOsqD0F5iWtHIS5/zUtL5g0V6xehNx6RA+H3QM0vDQ==
X-Received: by 2002:a17:902:ecca:b0:1c4:62a:e4a with SMTP id a10-20020a170902ecca00b001c4062a0e4amr576300plh.64.1694642846953;
        Wed, 13 Sep 2023 15:07:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bf095dfb76sm97776pld.237.2023.09.13.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:07:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:07:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 08/19] pstore: shrink the pstore_sb_lock critical section
 in pstore_kill_sb
Message-ID: <202309131507.E20F3AA130@keescook>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-9-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:02AM -0300, Christoph Hellwig wrote:
> ->kill_sb can't race with creating ->fill_super because pstore is a
> _single file system that only ever has a single sb instance, and we wait
> for the previous one to go away before creating a new one.  Reduce
> the critical section so that is is not held over generic_shutdown_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the refactoring!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
