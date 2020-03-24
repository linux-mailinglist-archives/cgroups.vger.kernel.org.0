Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703EE191964
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 19:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCXSqg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 14:46:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39730 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgCXSqg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 14:46:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so11077036qkf.6
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2020 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AGxmNy0595sT346CYB2mgtexQzuM2HSrDde9cVbZJuU=;
        b=M3QHtiDCjMkqKxWvyPl5FUJxxKx7+N4EaFCnKutVLtNtajUcahJKaZa0ow/Iz8n8vF
         +cTaGUSAx07luD6LuXpFlfEyxpVpWMxDTX6hfLOgkEyqWH71CUYPYpwYunw3m6+byoEx
         cqbsc7zfXkij/jLcSsAEnxMTyFJjLdeavZ1Vu5ZDBOCL+eZt1qHzjhNGrsKYVzKVUObo
         38MQ0gVgqyJ+wkY2WkU09z+gDjseha8Lgmr3Dty97if7NGwSTgddMDnEHu1RZkix40Ar
         GrX/0NCKWzRn+Dyf06srWhJwYIjlEymtoDhdE1UJmOXKCEqW3hgArIGXUehAAFjZC8Tk
         Mw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AGxmNy0595sT346CYB2mgtexQzuM2HSrDde9cVbZJuU=;
        b=Sbe8uSGVCSnsAbgpll6HAoL7+ucBN5dtRqIl2ftnUSzHA1cyUjCrFhrc1aTVrz9mec
         P5y+1lQdFyXEAWcw257cvu7iPTvJLbcugACIlZ0VhQypbmXldlkQJOgQNiwa4tF5ozBm
         cOsMkkNDzpJT3Z1qXjLwUGcwgEMJRp8qoYBb9saCUFza6D+OZhs1fzp1+07B1eXb38YN
         KfOzuj4KfwLrybzx0anYwqfTdydnThY0hyXPiInMAqy1el3JafYmc/vfwWYsvS0BAwr7
         IQqcH6Q7I2T2v7Y07f4N9JcvfiirV6DjW0i+0pqRJoTGN2WffFtoWUYUerPDKwlN8lO5
         QKOQ==
X-Gm-Message-State: ANhLgQ029pHcgVbk5En6mbaZgN+66jaYbrsW9bgcRjABa4+icXLD4qPK
        zDSeE8SCcskGsbuGY1y17DI=
X-Google-Smtp-Source: ADFU+vuG6EX8tZxW4p8BDfczrKaQLJMVhUXpXjJG5GIXYcXSAN+m6g533OhQ2NhTef+FX2Bno+4vPg==
X-Received: by 2002:a37:715:: with SMTP id 21mr28007993qkh.435.1585075595497;
        Tue, 24 Mar 2020 11:46:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::19c2])
        by smtp.gmail.com with ESMTPSA id j39sm8143061qtk.96.2020.03.24.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:46:34 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:46:33 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20200324184633.GH162390@mtj.duckdns.org>
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 17, 2020 at 12:03:20PM -0400, Kenny Ho wrote:
> What's your thoughts on this latest series?

My overall impression is that the feedbacks aren't being incorporated throughly
/ sufficiently.

Thanks.

-- 
tejun
