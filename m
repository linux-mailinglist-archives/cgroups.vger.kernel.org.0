Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F642E739
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2VPc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 17:15:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39753 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VPc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 May 2019 17:15:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so4438712qta.6
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q5EwstTJhgo/CmWvbkydomfc7Y5tM+FHszEHUfelsnI=;
        b=J++Vh0pi+jjTIaaZE9ElQ5pSaNpOAJzFFW8YjWcFxPPah+rXc9cdVeNvSK+15Evwc+
         zuica+uEyZVa0l+Q5Y7tS5zGzmSO2NClJ5AR2Nn858Diz5EaJICFnuVTbqn46bQXNbTa
         GkR7CfZWELzA0xEv77or9+oNoBwEj2NmgqF2FsiEciQX3cYaoJMB64YRtRWKqw4xyKqC
         2/XsTTR4GqVyTyZDnTAbPDQJpgjwaFDAenxOGw+lC8IS5zWzlpey+G2UMg/UY7yQY+Yy
         cweT0ORFhkpjlGM/aBGawbH103ooIVC1tR3G/zOyVSw2Lh5DC2du1035lLtPICx9Szv/
         sBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5EwstTJhgo/CmWvbkydomfc7Y5tM+FHszEHUfelsnI=;
        b=magrknoSkO73ChjLku6Rlx5uayniwLn3XB6j/9+B13mzN78AupDuSCaepMN1kW8naL
         eMbi0vNTBZlfd2Wvje14/AGY0qpTNPVIotNKn6vn8qLwvRfcBg8Gtrj2Qd+q8e/Ecqyn
         ZP26GkX/7XFxFqHWT7W68UTG2uciM+PpA671QPZS7sFLBwkUuw2/5QdheyfwmycA0kH1
         M2ecBS5qNX42N2Uu5ie+m0fQAtrJgef4OExfGJLfSJGYeEMQrmrM8zh5bmRX49b2QW7g
         L0InI1SWWX5rPOo2b01nE0Yq81RAWhoyo67cE9kWzJw0B3LFhvfdpCPMJ+BtOJVVM8ij
         Yxww==
X-Gm-Message-State: APjAAAWuVcqVFtO89RqUPq7peisMjcgixPQlofWB1M30fLwyEdpahKEB
        tZHdpdhg4IKfKShMdBYaZNE=
X-Google-Smtp-Source: APXvYqwtJsAQCorwt92UaL06uw44FCL8fslNaFAvjgA/BRG9GP3Ha0FgBHy+R+6H9qBX1JWXuSIP6w==
X-Received: by 2002:ac8:60d4:: with SMTP id i20mr125750qtm.376.1559164531703;
        Wed, 29 May 2019 14:15:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:849f])
        by smtp.gmail.com with ESMTPSA id o185sm289478qkd.64.2019.05.29.14.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 14:15:30 -0700 (PDT)
Date:   Wed, 29 May 2019 14:15:29 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/4] drm/amdkfd: Check against device cgroup
Message-ID: <20190529211529.GQ374014@devbig004.ftw2.facebook.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
 <20190517161435.14121-5-Harish.Kasiviswanathan@amd.com>
 <e547c0a1-e153-c3a6-79bc-67f59f364c3e@amd.com>
 <20190528190239.GM374014@devbig004.ftw2.facebook.com>
 <d39ec6a7-b30d-404b-c8d1-4e22604e0c8e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39ec6a7-b30d-404b-c8d1-4e22604e0c8e@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 29, 2019 at 08:45:44PM +0000, Kuehling, Felix wrote:
> Just to clarify, are you saying that we should upstream this change 
> through Alex Deucher's amd-staging-drm-next and Dave Airlie's drm-next 
> trees?

Yeah, sure, whichever tree is the most convenient.

Thanks.

-- 
tejun
