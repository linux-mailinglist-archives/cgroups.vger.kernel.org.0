Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56A79F4B8
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 00:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjIMWIM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjIMWIG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 18:08:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E019A8
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 15:08:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bf0decd032so202771a34.0
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694642880; x=1695247680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfjhWaT9cZxBP5V6PIM2mr46ku8Oc99YcLOA60af1KU=;
        b=Wi1LCj86ApS9gpVrE9naZ3qyr3fYpgNUpZFYmAIAApZONcdoNpurdU6KjHPdWqqylw
         zVtzPHyIJwJKksnoF71UPDPQN8Zibhn6mMHHna6ZOqxWBnUBsojK8KYqxDGZ/drjWr0O
         YtkBgcUwAtsa65E2n39fFUZDBcixbSlgv1o6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642880; x=1695247680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfjhWaT9cZxBP5V6PIM2mr46ku8Oc99YcLOA60af1KU=;
        b=ipflKQnQmdoqcBvyH8cxzvmTJsZ7Gh1pOu7hFkiYW9OzBLeKEpcbVQncE3BqDG5EWb
         y1wt0adWFh0lgSTDPPQ5HnjEutyF/ib2GPkU6yUdrJ4eWJuqrVbmT79xB5TikrOtpYwp
         lhGcStG4+ZGm40iQo+N0FhF7d5st6c5OU/5h5NlcEI8hJvXBnuqAs3Duf/on9PdbjW1M
         dgL+IOO0VFQoM9aZ5CiuoHEZDoj+fvUAHJ4Juk/NxJWos5ekR2/PKCuT850fhxhRKfCI
         PFNl+aP9SFb80bbKwvxgKZmBBXxOFZECwm2w5NYQQZ6pOS5joTaWiIlJy12WXnNuLeCl
         Uqew==
X-Gm-Message-State: AOJu0YwkLqYiNIizrbwB6AnzHH1SC+Psm6ml1SpzUYpQyrNaEMZ2Y0Pg
        MTilf+1aTWJcZD1OUqUOo6L+VhYGhEvYGhkWoXY=
X-Google-Smtp-Source: AGHT+IEZE3h3wTLMmi2pZgsbif5OpA7FowTFFztJjELuZ5utKxFD22kWo++unfbUiL/8y4QCIePvbQ==
X-Received: by 2002:a05:6358:4327:b0:132:d32d:d929 with SMTP id r39-20020a056358432700b00132d32dd929mr4380721rwc.20.1694642880172;
        Wed, 13 Sep 2023 15:08:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m30-20020a637d5e000000b0057411f9a516sm19425pgn.7.2023.09.13.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:07:59 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:07:59 -0700
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
Subject: Re: [PATCH 12/19] fs: convert kill_litter_super to litter_shutdown_sb
Message-ID: <202309131507.FAD836921D@keescook>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-13-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:06AM -0300, Christoph Hellwig wrote:
> Replace kill_litter_super with litter_shutdown_sb, which is wired up to
> the ->shutdown_sb method.  For file systems that wrapped
> kill_litter_super, ->kill_sb is replaced with ->shutdown and ->free_sb
> methods as needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org> # for pstore

-- 
Kees Cook
