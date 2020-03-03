Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12121778A3
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 15:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCCOTE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 09:19:04 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:35282 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCCOTE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 09:19:04 -0500
Received: by mail-qk1-f179.google.com with SMTP id 145so3527038qkl.2
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2020 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oblDflMFmo6oyKAhz2qvuc4P+V1BdLrKey9T3AjcUFA=;
        b=Po8WFETd8KA0o7u1QR91Uo3sKTtxSmFQ1dQuVU3C+cZJIo8Tcf/yq8ke+DHSa7ATpb
         xZpPhrp9/kE6HxZJDKRypPxMw9RBMHJYqPKZfwIb0rB+xFzzOE54jjHeZQ0KIqlqCzqR
         pStIkVP0vcAhKzeA+F0/N3GbY9hEFM6qp2JS1Fxfk7JqLxachpfCNSURnSiJnG2+Sh75
         mbLEXX2Kxyi+v+0JJ+b1r6pAYc+utUMap0TA+tDkuR4QXj1Amf7vkWvERHICuNtw7dHp
         fjPt+hC52L/6qIn6E/9ttx7spSD3Xr/qnhLGv1EJ7lMmeVNPxxKK7BWBIvjmq2wPDY3I
         NCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oblDflMFmo6oyKAhz2qvuc4P+V1BdLrKey9T3AjcUFA=;
        b=pkGbkM+PO5aV5elLcUFQfcExE/CBm8xnVbxr6SG7XQIJyBhVcKM3MHBkdaSJ2pgrv9
         VkYAixFQ92yNdrH2X5z7ATW7L9YN1FuhEcVehTDkfYJgRq+e8hohWBXDg3GjX0sXPdvV
         0N1Zf9/3rP2U7FbhAbruQG/ywr3703XTW0ExjgHmR7DYby/elYG60t6drM1+mYF5BLya
         PuvVjtnfrV1nS37LDLBvJrc0iiUlFJo2HPAOAaDIrTgfrKfT8TUGQvsS/VdIKYymAjIM
         ae2IdHKp5abWLR9dY1sMSy93r4ZehXemVEjDhOhocW/XJA6pWB2701PXt6urIW1eT5z+
         QznA==
X-Gm-Message-State: ANhLgQ1sNqZjFaXtA++bgWYM9nYIXypwZ+So7HRuSszOkgejPMVizPmd
        rY3RddJvu4VzkBkQdN4oXhQ=
X-Google-Smtp-Source: ADFU+vs2Iu89aO/dbihbrLBWTODJsQT78nmFx+6hTMsVFf+Amp25t315fUr8oAQFg3B/RRIi7RVWig==
X-Received: by 2002:a37:b11:: with SMTP id 17mr4300588qkl.384.1583245143420;
        Tue, 03 Mar 2020 06:19:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id m200sm12237164qke.135.2020.03.03.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:19:02 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:19:02 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org
Subject: Re: [BUG] NULL pointer de-ref when setting io.cost.qos on LUKS
 devices
Message-ID: <20200303141902.GB189690@mtj.thefacebook.com>
References: <1dbdcbb0c8db70a08aac467311a80abcf7779575.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbdcbb0c8db70a08aac467311a80abcf7779575.camel@sipsolutions.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Mar 03, 2020 at 03:13:10PM +0100, Benjamin Berg wrote:
> so, I tried to set io.latency for some cgroups for the root device,
> which is ext4 inside LVM inside LUKS.

It's pointless on compound devices. I think the right thing to do here
is disallowing to enable it on those devices.

Thanks.

-- 
tejun
