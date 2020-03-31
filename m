Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59A919998C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgCaPZg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 11:25:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgCaPZg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 11:25:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so26501752wro.7
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2020 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YTzVrLlnv/U861L9j2OH30y80LBa/uThEvzXvP/gh2c=;
        b=MX3SlhqtOgu7+xXPL0VtCywalercn8WvcRrstjEE7UrqsuB7MOfCn54non2gPg5X59
         uLet+fnVhtkcLmoWl91/g5RA8oxVdZsQT8JOjXegkF08l25QW2YHmBU2fGuolcm2oQCG
         THSGdBz4PAgk6GtfOmO2lXmtTDQFqofruA8cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTzVrLlnv/U861L9j2OH30y80LBa/uThEvzXvP/gh2c=;
        b=ABWXLfXeseGRML9ZRu9MnxtLe3DUh4yzzE4s74IBQFbTlb88KqULYvc91Ct7Y1qWCt
         ix8W8zwZsiEb6PtNGF3eSTp3m1FptTqmQoouY9YTn7zGAWdoQXcudTBvbza7sADQXoVd
         Jd6Jc1QxXO9D7QLgG5Zarv3wB6aMhe0XDz7TP5P7QPHf1p7bOJn7oL7zHGRnTCPcJHVm
         uCK9zTTn1VYJx+fEnKDQhIpFmDbcTtbCVH3Be2FHh/f6LGQqAUVvk3WZl8gtsBxqmu17
         UOEOnxP+ncJl3pIGHb31lU8RvmPYlYGgF+SP4DsCZzq77wMKszrqzkib5OKBJrdQ2WLn
         s4Mg==
X-Gm-Message-State: ANhLgQ0ufoRbenW6vGMi8oDHuuQPerA5fD01N+E/PYHPQdj1/DS0oJj6
        fh9SHVsgvDPZxYLDqsk4x5LYIw==
X-Google-Smtp-Source: ADFU+vtwJF1/nQQsqo4I3dRj5KZv3ZcoTKSDqx3vwC8HQz+R1N9Nja42TBa60n4K9gVoKNdsr+oLCw==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr20090187wrp.270.1585668335013;
        Tue, 31 Mar 2020 08:25:35 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:27bd])
        by smtp.gmail.com with ESMTPSA id u22sm4278976wmu.43.2020.03.31.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:25:34 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:25:34 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331152534.GA972283@chrisdown.name>
References: <20200331152424.GA1019937@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200331152424.GA1019937@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrew, this is a pretty bad one that could definitely affect memory.high 
users. We should probably expedite it going in.

Sorry for the trouble, especially on a -stable patch...
